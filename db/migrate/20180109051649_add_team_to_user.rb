class AddTeamToUser < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :team, :string
  end
end
