class Participant < ActiveRecord::Base
	validates :login, uniqueness: true
	validates :login, presence: true

	def to_param
		login
	end

end
