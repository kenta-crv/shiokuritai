class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @rooms = Room.active.where(user_id: current_user.id)
  end
end
