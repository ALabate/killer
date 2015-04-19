class CreateAdmins < ActiveRecord::Migration
  def change
    create_table :admins do |t|
      t.string :student_id

      t.timestamps null: false
    end
  end
end
