class AddGameReferenceToParticipant < ActiveRecord::Migration
  def change
    add_reference :participants, :game, index: true, foreign_key: true
  end
end
