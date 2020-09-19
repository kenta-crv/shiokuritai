class Message < ApplicationRecord
  belongs_to :room
  belongs_to :estimate, optional: true

  validates :content, presence: true
end
