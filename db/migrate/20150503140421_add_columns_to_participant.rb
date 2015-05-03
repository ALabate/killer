class AddColumnsToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :student_id, :string
    add_column :participants, :email, :string
    add_column :participants, :first_name, :string
    add_column :participants, :last_name, :string
    add_column :participants, :image, :string
  end
end
