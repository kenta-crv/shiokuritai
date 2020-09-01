class ApplicationController < ActionController::Base
  before_action :set_host

  # 例外処理

   rescue_from ActiveRecord::RecordNotFound, with: :render_404 unless Rails.env.development?
   rescue_from ActionController::RoutingError, with: :render_404 unless Rails.env.development?
   rescue_from Exception, with: :render_500 unless Rails.env.development?

   def set_host
      Rails.application.routes.default_url_options[:host] = request.host_with_port
   end

   def render_404
    render template: 'errors/error_404', status: 404, layout: 'application', content_type: 'text/html'
   end

   def render_500
    render template: 'errors/error_500', status: 500, layout: 'application', content_type: 'text/html'
   end

  def has_company?
    if current_member.companies.count < 1
      redirect_to new_company_path, notice: '会社情報を登録して下さい。'
      return false
    end
  end

  def set_company
    @current_company = current_member.companies.find(params[:company_id])
  end

  def current_company
    @current_company
  end

private
  def after_sign_in_path_for(resource)
    case resource
    when User
      "/" #ユーザー登録と相談を兼ねる
    when Admin
      "/" #先々一覧を見れるアナリティクスへ
    when Member
      "/companies/new"
    when Worker
      "/lists/new"
    else
      "/"
    end
  end

  #UserとStaffがありログアウト画面に推移
  def after_sign_out_path_for(resource)
    case resource
    when User, :user, :users
      "/"
    when Admin, :admin, :admins
      "/"
    when Member, :member, :members
      "/"
    when Worker, :worker, :workers
      "/"
    else
       super
    end
  end
end
