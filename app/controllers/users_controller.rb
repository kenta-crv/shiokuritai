class UsersController < ApplicationController
  before_action :redirect_invalid_user

  def show
    @user = User.find(params[:id])
    @rooms = Room.active.where(user_id: current_user.id)
  end

  def redirect_invalid_user
    #userとしてログインしていないとログイン画面へ繊維
    authenticate_user!
    #current_userが正しいuserか確認
    user = User.find(params[:id])
    redirect_to root_path unless correct_user?(user)
  end
end
