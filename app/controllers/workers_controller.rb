class WorkersController < ApplicationController
  def show
    @worker = Worker.find(params[:id])
    @lists = List.where(worker_id: current_worker.id)
    @count_day = @lists.where('updated_at > ?', Time.current.beginning_of_day).where('updated_at < ?', Time.current.end_of_day).count
    @count_week = @lists.where('updated_at > ?', Time.current.beginning_of_week).where('updated_at < ?', Time.current.end_of_week).count
    @count_month = @lists.where('updated_at > ?', Time.current.beginning_of_month).where('updated_at < ?', Time.current.end_of_month).count
  end
end
