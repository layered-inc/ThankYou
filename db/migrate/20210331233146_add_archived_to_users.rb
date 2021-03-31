class AddArchivedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :archived, :boolean, default: false
    add_index :users, :archived
  end
end
