class AdminsController < ApplicationController
  before_action :authenticate_admin!
  
  def show
    @admin = Admin.find(params[:id])
    @lists = List.all
    @workers = Worker.all
    @count_day = @lists.where('updated_at > ?', Time.current.beginning_of_day).where('updated_at < ?', Time.current.end_of_day).count
    @count_week = @lists.where('updated_at > ?', Time.current.beginning_of_week).where('updated_at < ?', Time.current.end_of_week).count
    @count_month = @lists.where('updated_at > ?', Time.current.beginning_of_month).where('updated_at < ?', Time.current.end_of_month).count
    @rooms = Room.active
  end
end
