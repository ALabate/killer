class DropColumnStudentIdFromAdmin < ActiveRecord::Migration
   def change
  	remove_column :admins, :student_id
  end
end
