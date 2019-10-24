class AddUsersToGameUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :game_users do |t|
      t.references :game
      t.references :user
    end
  end
end
