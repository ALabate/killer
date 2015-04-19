class DropColumnStudentIdFromParticipant < ActiveRecord::Migration
  def change
  	remove_column :participants, :student_id
  end
end
