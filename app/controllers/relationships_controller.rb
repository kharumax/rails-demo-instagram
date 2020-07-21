class RelationshipsController < ApplicationController
  before_action :authenticate_user!

  def create
    @user = User.find_by(id: params[:followed_id])
    current_user.follow(@user)
    respond_to :js
  end

  def destroy
    @user = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow(@user)
    respond_to :js
  end

end
