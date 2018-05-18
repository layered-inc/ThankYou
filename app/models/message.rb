# == Schema Information
#
# Table name: messages
#
#  id           :integer          not null, primary key
#  sender_id    :integer
#  recipient_id :integer
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  likes_count  :integer
#

class Message < ApplicationRecord
  # Message ModelからはUser Modelを(.userメソッドではなく)sender or recipient メソッドで参照
  # messagesテーブルの外部キーはsender_id or recipient_id フィールド
  belongs_to :sender, foreign_key: :sender_id, class_name: 'User', inverse_of: :messages
  belongs_to :recipient, foreign_key: :recipient_id, class_name: 'User', inverse_of: :messages

  has_many :likes, dependent: :destroy

  max_paginates_per 20

  validates :recipient, presence: true
  validates :body, presence: true

  scope :send_messages, ->(user_id) do
    where(sender_id: user_id)
  end

  scope :date_limit, ->(date) do
    where("created_at <= ?", date)
  end

  scope :recipient_messages, ->(user_id) do
    where(recipient_id: user_id)
  end

  # scopeは長い条件文を省略するために使用
  scope :involving, ->(user) do
    where("messages.sender_id = :q OR messages.recipient_id = :q", q: user.id)
  end

  scope :between, ->(sender_id, recipient_id) do
    where("(messages.sender_id = ? AND messages.recipient_id =?) OR (messages.sender_id = ? AND messages.recipient_id =?)", sender_id, recipient_id, recipient_id, sender_id)
  end

  def like_user(user_id)
    likes.find_by(user_id: user_id)
  end
end
