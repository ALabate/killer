class AddStateMAchineColumnToTarget < ActiveRecord::Migration
  def change
    add_column :targets, :aasm_state, :string
  end
end
