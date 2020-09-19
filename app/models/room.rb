class Room < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :member, optional: true
  has_many :messages, dependent: :destroy
  has_many :estimates, through: :messages

  before_validation :set_uri_token

  # default 0 に設定してある
  enum status: {
    "active_room": 0,
    "end_message": 1,
    "deleted_messanger": 2,
  }

  scope :active, -> { where(status: "active_room") }

  private
    def set_uri_token
      self.uri_token = uri_token.blank? ? generate_uri_token : uri_token
    end

    def generate_uri_token
      uri_token = SecureRandom.uuid
      self.class.where(uri_token: uri_token).blank? ? uri_token : generate_uri_token
    end
end
