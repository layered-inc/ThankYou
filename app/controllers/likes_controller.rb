class LikesController < ApplicationController
  before_action :authenticate_user!
  protect_from_forgery except: %i[create destroy]

  def create
    @like = Like.create(user_id: current_user.id, message_id: params[:message_id])

    likes_count = Like.where(message_id: params[:message_id]).count
    render json: { count: likes_count }, status: :ok
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, message_id: params[:message_id])
    like.destroy
    likes_count = Like.where(message_id: params[:message_id]).count
    render json: { count: likes_count }, status: :ok
  end
end
