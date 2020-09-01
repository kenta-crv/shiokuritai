class CreateLists < ActiveRecord::Migration[5.2]
  def change
    create_table :lists do |t|
      t.string :company #会社名
      t.string :name
      t.string :tel
      t.string :fax
      t.string :postnumber #郵便番号
      t.string :prefecture
      t.string :city
      t.string :town
      t.string :chome
      t.string :building
      t.string :mail #URL
      t.string :url #URL
      t.string :usp #強み
      t.string :caption #資本金
      t.string :people #従業員数
      t.string :image

      t.string :foundation #設立日
      t.string :contact_url #問い合わせ　
      t.string :number_of_business #事業所数 →　n
      t.string :number_of_store #店舗数

      t.string :explanation #解説

      t.string :access #アクセス
      t.string :holiday #休日
      t.string :business_hour #営業時間
      t.string :price #価格
      t.references :admin
      t.timestamps
    end
  end
end
