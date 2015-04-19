class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.string :login
      t.string :student_id

      t.timestamps null: false
    end
  end
end
