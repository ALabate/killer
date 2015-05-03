class CreateTargets < ActiveRecord::Migration
  def change
    create_table :targets do |t|
    	t.integer :hunter_id, index: true, foreign_key: true
      	t.integer :pursued_id, index: true, foreign_key: true
      	t.timestamps null: false
    end
  end
end
