class Estimate < ApplicationRecord
  belongs_to :user

  include JpPrefecture
  jp_prefecture :prefecture_code

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_code).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_code = JpPrefecture::Prefecture.find(name: prefecture_name).code
  end
  #belongs_to :company
  validates :first_name, {presence: true}  #苗字
  validates :last_name, {presence: true}  #名前
  validates :first_kana, {presence: true}  #ミョウジ
  validates :last_kana, {presence: true}  #ナマエ
  validates :tel, {presence: true} #電話番号
  validates :email, {presence: true} #メールアドレス
  validates :prefecture_code, {presence: true} #都道府県コード
  validates :city, {presence: true} #市区町村
  validates :town, {presence: true} #URL
  validates :worries, {presence: true} #建物
  validates :importance, {presence: true} #面積
  validates :period, {presence: true} #解体時期
  validates :remarks, {presence: true} #解体時期
end
