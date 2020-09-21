class User < ApplicationRecord
  has_one :company
  has_many :estimates, dependent: :destroy
  has_many :rooms
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  after_destroy :update_room_status

  private
    def update_room_status
      Room.where(user_id: self.id).update_all(status: "deleted_messanger")
    end
end
