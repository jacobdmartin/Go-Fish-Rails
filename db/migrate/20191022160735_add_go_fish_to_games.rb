class AddGoFishToGames < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :go_fish, :jsonb
  end
end
