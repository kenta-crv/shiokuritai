class EstimatesController < ApplicationController
  before_action :authenticate_member!, only: :apply
  before_action :authenticate_admin!, only: [:index, :show]
  before_action :authenticate_user!, only: [:new, :confirm, :thanks]

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
    @estimate.user_id = current_user.id
    current_user.update(
      first_name: estimate_params[:first_name], 
      last_name: estimate_params[:last_name]
    )
    @estimate.save
    EstimateMailer.received_email(@estimate).deliver
    EstimateMailer.client_email(@estimate).deliver
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

  def apply
    estimate = Estimate.find(params[:id])
    room = estimate.rooms.find_by(member_id: current_member.id)

    if room.blank?
      # 初めての場合
      if current_member.point >= 10
        # ポイントを減らす
        current_member.update(point: current_member.point - 10)
        room = Room.get_room_in(estimate.user, current_member)
        content = "お名前: #{estimate.first_name} #{estimate.last_name}（#{estimate.first_kana}#{estimate.last_kana}）\n電話番号: #{estimate.tel}\nメールアドレス: #{estimate.email}\n住所: #{estimate.prefecture.name}#{estimate.city}#{estimate.town}\n相談内容: #{estimate.worries}\n重要な点: #{estimate.importance}\n必要時期: #{estimate.period}ヶ月以内\n相談本文: #{estimate.remarks}"
        Message.create(is_user: true, room_id: room.id, content: content, estimate_id: estimate.id)
        redirect_to room_messages_path(uri_token: room.uri_token)
      else
        redirect_to member_path(current_member), alert: "ポイントが足りません"
      end
    else
      # 既に応募済の場合
      redirect_to room_messages_path(uri_token: room.uri_token)
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
