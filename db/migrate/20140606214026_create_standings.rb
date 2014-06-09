class CreateStandings < ActiveRecord::Migration
  def change
    create_table :standings do |t|
      t.integer :team_id
      t.integer :games_played
      t.integer :wins
      t.integer :losses
      t.integer :draw
      t.integer :goals_for
      t.integer :goals_against
      t.integer :rank
      t.integer :change
      t.integer :group_id
      t.timestamps
    end
  end
end
