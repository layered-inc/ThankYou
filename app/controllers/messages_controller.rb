class MessagesController < ApplicationController
  before_action :authenticate_user!, only: %i[new index search create]
  before_action :set_messages, only: %i[index search]
  before_action :set_users, only: %i[new index search]

  def index; end

  def search
    # a_user_id にするのは 検索urlの場合は パラメータのpageの前に来ないとInfiniteScrollはうまく作動したため
    if (@user_id = params[:a_user_id])
      if params[:button] == 'sender'
        @messages = @messages.send_messages(@user_id)
      else
        @messages = @messages.recipient_messages(@user_id)
      end
    end

    render 'index'
  end

  def new
    render layout: false
  end

  def create
    @message = Message.new(massage_params)
    @message.recipient_id = params[:recipient_id]
    @message[:body] = @message.body.to_plain_text

    # ActionCable.server.broadcast 'message_channel', message: render_message(@message) if @message.save!

    if @message.save!
      redirect_to messages_path
      # # create.js.erb　が実行される
      # respond_to do |format|
      #   format.js
      # end
    end
  end

  def destroy
    @message = Message.find(params[:id])
    if @message.destroy
      flash[:notice] = "メッセージを削除しました!"
      redirect_to messages_path
    else
      render json: { message: @message.errors.full_messages.join(", ") }
    end
  end

  # def full_text
  #   message = Message.all.pluck(:body)
  #
  #   @messages = shellesc(message.join(',').delete("'").delete('"'))
  #
  #   render layout: false
  # end

  private

  # def shellesc(str, opt = {})
  #   str = str.dup
  #   if opt[:erace]
  #     opt[:erace] = [opt[:erace]] unless Array === opt[:erace]
  #     opt[:erace].each do |i|
  #       case i
  #       when :ctrl then
  #         str.gsub!(/[\x00-\x08\x0a-\x1f\x7f]/, '')
  #       when :hyphen then
  #         str.gsub!(/^-+/, '')
  #       else
  #         str.gsub!(i, '')
  #       end
  #     end
  #   end
  #   str.gsub!(/[\!\"\$\&\'\(\)\*\,\:\;\<\=\>\?\[\\\]\^\`\{\|\}\t ]/, '\\\\\\&')
  #   str
  # end

  def massage_params
    params.require(:message).permit(:body, :sender_id)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: current_user || { id: '' } })
  end

  def set_users
    @users = User.where(archived: false)
  end

  def set_messages
    @current_user_id = current_user&.id
    @messages = Message.send_messages(current_user).or(Message.date_limit('20210101')).includes(:sender, :recipient, :rich_text_body).order('updated_at DESC').page(params[:page]).without_count
    # @messages = Message.includes(:sender, :recipient, :rich_text_body).order('updated_at DESC').page(params[:page]).without_count
  end
end
