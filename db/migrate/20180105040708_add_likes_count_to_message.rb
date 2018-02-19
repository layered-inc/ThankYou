class AddLikesCountToMessage < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :likes_count, :integer
  end
end
