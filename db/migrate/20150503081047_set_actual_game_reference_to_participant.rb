class SetActualGameReferenceToParticipant < ActiveRecord::Migration
  def change
  	game = Game.first
  	Participant.all.each do |participant|
  		participant.game = game
  		participant.save!
  	end
  end
end
