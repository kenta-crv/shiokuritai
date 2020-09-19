class EstimatesController < ApplicationController
  def index
    @estimates = Estimate.order(created_at: "DESC").page(params[:page])
  end

  def new
    @estimate = Estimate.new
  end

  def confirm
    @estimate = Estimate.new(estimate_params)
    render :new if @estimate.invalid?
  end

  def thanks
    @estimate = Estimate.new(estimate_params)
    @estimate.save
    EstimateMailer.received_email(@estimate).deliver
    # EstimateMailer.client_email(@estimate).deliver
    EstimateMailer.send_email(@estimate).deliver
  end

  def create
    @estimate = Estimate.new(estimate_params)
    render :new and return if params[:back] || !@estimate.save
    redirect_to thanks_estimates_path
  end

  def show
    @estimate = Estimate.find(params[:id])
  end

  def edit
    @estimate = Estimate.find(params[:id])
  end

  def destroy
    @estimate = Estimate.find(params[:id])
    @estimate.destroy
     redirect_to estimates_path
  end

  def update
    @estimate = Estimate.find(params[:id])
    if @estimate.update(estimate_params)
      redirect_to estimates_path
    else
      render 'edit'
    end
  end

  private
  def estimate_params
    params.require(:estimate).permit(
      :first_name,
      :last_name,
      :first_kana,
      :last_kana,
      :tel,
      :email,
      :prefecture,
      :city,
      :town,
      :worries,
      :importance,
      :period,
      :remarks,
      :postcode,
      :prefecture_code, 
      :prefecture_name, 
      :address_city,
      :address_street,
      :address_building
    )
  end
end
