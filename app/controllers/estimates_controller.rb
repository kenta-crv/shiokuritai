class EstimatesController < ApplicationController
  before_action :authenticate_member!, only: [:apply, :confirm_point]
  before_action :authenticate_admin!, only: [:index, :show, :edit, :update, :destroy, :send_mail]

  def index
    @estimates = Estimate.order(created_at: "DESC").page(params[:page])
  end

  def new
    @estimate = Estimate.new
  end

  def confirm
    @estimate = Estimate.new(estimate_params)
    render :new if @estimate.invalid? || invalid_user || double_email
  end

  def thanks
    @estimate = Estimate.new(estimate_params)
    create_user if current_user.blank?
    @estimate.user_id = current_user.id
    @estimate.save
    EstimateMailer.received_email(@estimate).deliver # 管理者に通知
    EstimateMailer.send_email(@estimate).deliver # 送信者に通知
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
    redirect_to estimates_path, alert: "削除しました"
  end

  def update
    @estimate = Estimate.find(params[:id])
    if @estimate.update(estimate_params)
      redirect_to estimate_path(@estimate), alert: "更新しました"
    else
      render 'edit'
    end
  end

  def send_mail
    @estimate = Estimate.find(params[:id])
    @estimate.update(send_mail_flag: true)
    EstimateMailer.client_email(@estimate).deliver # 全企業に送信
    redirect_to estimate_path(@estimate), alert: "送信しました"
  end

  def confirm_point
    @estimate = Estimate.find(params[:id])
    room = @estimate.rooms.find_by(member_id: current_member.id)

    if room.present?
      # 既に応募済の場合
      return redirect_to room_messages_path(uri_token: room.uri_token)
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
        redirect_to room_messages_path(uri_token: room.uri_token), alert: "10ポイント消費しました"
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
      :address_building,
      :user_name,
      :user_password
    )
  end

  def invalid_user
    # userがいるか
    if current_user
      return false
    end
    # nameが入っているか
    if estimate_params[:user_name].blank?
      return true
    end
    # passwordが入っているか
    if estimate_params[:user_password].blank?
      return true
    end
    return false
  end

  def double_email
    # userがいるか
    if current_user
      return false
    end
    # 同じメールアドレスの人がいるか
    user = User.find_by(email: estimate_params[:email])
    if user.present?
      return true
    end
    return false
  end

  def create_user
    user = User.create(
      user_name: estimate_params[:user_name],
      password: estimate_params[:user_password],
      email: estimate_params[:email],
      confirmed_at: Time.current
    )
    EstimateMailer.regist_user(user).deliver
    sign_in user
  end
end
