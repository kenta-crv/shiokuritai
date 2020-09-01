class ListsController < ApplicationController
before_action :authenticate_worker!, only: [:new, :edit]
  def index
    @q = List.ransack(params[:q])
    @lists = @q.result
    @lists = @lists.page(params[:page]).per(20).order(created_at: :desc)
    respond_to do |format|
     format.html
     format.csv{ send_data @lists.generate_csv, filename: "lists-#{Time.zone.now.strftime('%Y%m%d%S')}.csv" }
    end
  end

  def show
    @list = List.find(params[:id])
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
        redirect_to lists_path
    else
        render 'new'
    end
  end

  def edit
    @list = List.find(params[:id])
  end

 def update
    @list = List.find(params[:id])
     if @list.update(list_params)
        redirect_to lists_path
    else
        render 'edit'
    end
 end

 def destroy
    @list = List.find(params[:id])
    @list.destroy
    redirect_to lists_path
 end

 def import
   List.import(params[:file])
   redirect_to root_url, notice:"リストを追加しました"
 end

private
 def list_params
  params.require(:list).permit(
    :company, #会社名
    :name, #
    :tel,
    :fax,
    :postnumber, #郵便番号
    :prefecture,
    :city,
    :town,
    :chome,
    :building,
    :mail, #URL
    :url, #URL
    :usp, #強み
    :caption, #資本金
    :people, #従業員数
    :image,

    :foundation, #設立日
    :contact_url, #問い合わせ　
    :number_of_business, #事業所数 →　n
    :number_of_store, #店舗数

    :explanation, #解説

    :access, #アクセス
    :holiday, #休日
    :business_hour, #営業時間
    :price, #価格

    )&.merge(worker: current_worker)
  end
end
