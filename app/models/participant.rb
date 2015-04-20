class Participant < ActiveRecord::Base
	validates :login, uniqueness: true
	validates :login, presence: true
	validates_with EtuUttLoginValidator, on: :create

	def to_param
		login
	end
	
end
