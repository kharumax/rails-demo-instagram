class UsersController < ApplicationController

  def show
    @user = User.find_by(id: params[:id])
  end

  def index
    @users = User.all
    if params[:search]
      keywords = params[:search].split(/[[:blank:]]+/).select(&:present?)
      keywords.each do |keyword|
        @users = @users.where(["name LIKE ?","%#{keyword}%"])
      end
    end
  end

end
