# == Schema Information
#
# Table name: likes
#
#  id         :bigint(8)        not null
#  message_id :integer
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Like < ApplicationRecord
  belongs_to :message, counter_cache: :likes_count
  belongs_to :user
end
