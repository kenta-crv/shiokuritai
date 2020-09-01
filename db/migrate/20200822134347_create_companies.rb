class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
      create_table :companies do |t|
        t.string :company #会社名
        t.string :first_name #代表者
        t.string :last_name #
        t.string :tel_front
        t.string :tel_middle
        t.string :tel_back
        t.string :fax_front
        t.string :fax_middle
        t.string :fax_back
        t.string :postnumber #郵便番号
        t.string :prefecture
        t.string :city
        t.string :town
        t.string :town_number
        t.string :building
        t.string :mail #URL
        t.string :url #URL
        t.string :usp #強み
        t.string :people #従業員数
        t.string :image
        t.string :foundation #設立日

        t.string :handing_business #取扱業務
        t.string :access #アクセス
        t.string :holiday #休日
        t.string :business_hour #営業時間
        t.string :price #価格

        t.string :explanation #意気込み

        t.string :access #アクセス
        t.string :holiday #休日
        t.string :business_hour #営業時間
        t.string :price #価格

        t.string :bookmark
        t.string :company_yomi
        t.string :name_yomi
        t.string :title_title
        t.string :title_image
        t.string :title_detail
        t.string :profile_title
        t.string :profile_image
        t.string :profile_detail
        t.string :address_image
        t.string :address_detail
        t.string :consultation_fee #相談料
        t.string :commitment

        t.references :admin
        t.references :user
        t.references :member
        t.timestamps
    end
  end
end
