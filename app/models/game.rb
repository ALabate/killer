class Game < ActiveRecord::Base
	has_many :players, -> { validated }, :class_name => 'Participant'

	# Allocate players target for the first time
	def allocate_players_targets

		players = self.players.shuffle

		players.each_with_index do |player,index|

			if index < players.count - 1
				Target.create!(hunter: player, pursued: players[index+1])
			else
				Target.create!(hunter: player, pursued: players.first)
			end
			#PlayerMailer.opening_email(player).deliver_now
		end

		nil
		
		# TODO: Send an email to the players
	end

	# Return the current game
	def self.current
		return Game.last
	end

	# Is the game open ?

	def open?
		Time.now >= self.beginning && Time.now <= self.ending
	end
end
