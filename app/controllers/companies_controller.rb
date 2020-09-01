class CompaniesController < ApplicationController
before_action :authenticate_member!, except: :index
before_action :authenticate_admin!, only: :index

  def index
    @q = Company.ransack(params[:q])
    @companies = @q.result
    @companies = @companies.page(params[:page]).per(20).order(created_at: :desc)
  end

  def show
    @company = Company.find(params[:id])
  end

  def new
    @company = Company.new(member_id: current_member.id)
  end

  def create
    @company = Company.new(company_params)
    @company.member_id = current_member.id
    if params[:back]
      render new_company_path
    elsif @company.save
      render thanks_companies_path
    else
      render new_company_path
    end
  end

  def edit
    @company = Company.find(member_id: current_member.id)
    #@company.member_id = current_member.id
  end

 def update
    @company = Company.find(params[:id])
    @company.member_id = current_member.id
    if @company.update(company_params)
        redirect_to "/members/#{current_member.id}"
    else
        render 'edit'
    end
 end

  def confirm
    @company = Company.new(company_params)
    @company.member_id = current_member.id
    render :new if @company.invalid?
  end

  def thanks
    @company = Company.new(company_params)
    CompanyMailer.received_email(@company).deliver
    CompanyMailer.send_email(@company).deliver
  end

 def destroy
    @company = Company.find(params[:id])
    @company.destroy
    redirect_to companies_path
 end

 def import
   Company.import(params[:file])
   redirect_to root_url, notice:"リストを追加しました"
 end

 def pay
 end

private
 def company_params
  params.require(:company).permit(
    :company, #会社名
    :first_name, #代表者
    :last_name, #
    :tel_front,
    :tel_middle,
    :tel_back,
    :fax_front,
    :fax_middle,
    :fax_back,
    :postnumber, #郵便番号
    :prefecture,
    :city,
    :town,
    :town_number,
    :building,
    :mail, #URL
    :url, #URL
    :usp, #強み
    :people, #従業員数
    :image,
    :foundation, #設立日

    :explanation, #解説

    :access, #アクセス
    :holiday, #休日
    :business_hour, #営業時間
    :price, #価格

    :bookmark,
    :company_yomi,
    :name_yomi,
    :title_title,
    :title_image,
    :title_detail,
    :profile_title,
    :profile_image,
    :profile_detail,
    :address_image,
    :address_detail,
    :consultation_fee, #相談料
    :commitment

  )#.merge(member_id: @member_id)
  end
end
