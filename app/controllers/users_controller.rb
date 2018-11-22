class UsersController < ApplicationController
  require 'net/http'
  require 'net/https'

  def personality_insights
    message_text = Message.send_messages(params[:user_id]).pluck(:body).join
    return false if message_text.blank?

    http, req = make_request(message_text)

    @re = {}
    begin
      ActiveRecord::Base.transaction do
        # Fetch Request
        res = http.request(req)
        @re_obj = JSON.parse(res.body)
        @re = res.body.to_s.force_encoding("UTF-8")
        @user = User.find(params[:user_id])
      end
    rescue StandardError => e
      LOG.debug 'Error Exception!', e
    end

    render layout: false
  end

  def dashboards
    @send_label = []
    @send_data = []
    @recipient_label = []
    @recipient_data = []

    @recipient_nums = 0
    @send_nums = 0

    if params[:user_id].present?
      Message.recipient_messages(params[:user_id]).limit(8).group(:sender_id).order('count_all desc').count.each do |message|
        @recipient_label << User.find(message[0]).name
        @recipient_data << message[1]
      end

      @recipient_nums = Message.recipient_messages(params[:user_id]).count

      Message.send_messages(params[:user_id]).limit(8).group(:recipient_id).order('count_all desc').count.each do |message|
        @send_label << User.find(message[0]).name
        @send_data << message[1]
      end

      @send_nums = Message.send_messages(params[:user_id]).count
    end

    render layout: false
  end


  private

  def make_request(message_text)
    uri = URI(ENV['PERSONALITY_ENDPOINT'])

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_PEER

    req = Net::HTTP::Post.new(uri)
    req.add_field "Authorization", "Basic #{ENV['PERSONALITY_TOKEN']}"
    req.add_field "Content-Type", "text/plain"
    req.add_field "Accept", "application/json"
    req.add_field "Content-Language", "ja"
    req.add_field "Accept-Language", "ja"
    req.body = message_text

    [http, req]
  end
end

