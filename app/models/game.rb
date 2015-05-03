class Game < ActiveRecord::Base
	has_many :players, -> { validated }, :class_name => 'Participant'

	# Allocate players target for the first time
	def allocate_players_targets

		players = self.players.shuffle

		players.each_with_index do |player,index|
			if index < players.count - 1
				player.targeted_players << players[index+1]
			else
				player.targeted_players << players.first
			end
		end

		# TODO: Send an email to the players
	end
end
