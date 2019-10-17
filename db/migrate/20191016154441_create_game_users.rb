class CreateGameUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :game_users do |t|

      t.timestamps
    end
  end
end
