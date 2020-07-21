class LikesController < ApplicationController
  before_action :likes_exist?,only: [:create]
  before_action :authenticate_user!

  def create
    @like = current_user.likes.build(likes_params)
    @post = @like.post
    if @like.save
      respond_to :js
    end
  end

  def destroy
    @like = Like.find_by(id: params[:id])
    @post = @like.post
    if @like.destroy
      respond_to :js
    end
  end

  private

  def likes_params
    params.permit(:post_id)
  end

  def likes_exist?
    @post = Post.find_by(id: params[:post_id])
    redirect_to root_url if Like.find_by(user_id: current_user.id,post_id: @post.id)
  end

end
