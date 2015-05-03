class Game < ActiveRecord::Base
	has_many :players, -> { validated }, :class_name => 'Participant'
end
