class CreateUsersTeams < ActiveRecord::Migration
  def change
    create_table :users_teams do |t|
      t.integer :user_id
      t.integer :team_id
      t.timestamps
    end

    add_index :users_teams, [:user_id, :team_id], :unique => true
  end
end
