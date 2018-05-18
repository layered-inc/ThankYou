class MessagesController < ApplicationController
  before_action :authenticate_user!, only: %i[new index search create]
  before_action :set_messages, only: %i[index search]
  before_action :set_users, only: %i[new index search]

  def index; end

  def search
    @user_id = params[:searching_user_id] || nil
    if @user_id.present?
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

  private

  def massage_params
    params.require(:message).permit(:body, :sender_id)
  end

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message, current_user: current_user || { id: '' } })
  end

  def set_users
    @users = User.all
  end

  def set_messages
    @current_user_id = current_user&.id
    @messages = Message.send_messages(current_user).or(Message.date_limit('20180430')).includes(:sender, :recipient).order('updated_at DESC').page params[:page]
    # @messages = Message.includes(:sender, :recipient).order('updated_at DESC').page params[:page]
  end
end
