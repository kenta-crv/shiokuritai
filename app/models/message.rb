class Message < ApplicationRecord
  belongs_to :room
  belongs_to :estimate, optional: true

  validates :content, presence: true

  def self.read(room, read_user)
    if read_user.class.name == 'User'
      # memberからのメッセージに既読をつける
      self.where(room_id: room.id, is_read: false, is_user: false).update_all(is_read: true)
    else
      # userからのメッセージに既読をつける
      self.where(room_id: room.id, is_read: false, is_user: true).update_all(is_read: true)
    end
  end

  def n_days_ago?(n)
    created_at >= Time.current.ago(n.days)
  end
end
