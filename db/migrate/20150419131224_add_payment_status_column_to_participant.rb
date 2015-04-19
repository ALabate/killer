class AddPaymentStatusColumnToParticipant < ActiveRecord::Migration
  def change
    add_column :participants, :paid, :boolean, default: false
  end
end
