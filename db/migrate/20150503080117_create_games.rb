class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :beginning
      t.datetime :ending

      t.timestamps null: false
    end
  end
end
