class Admin < ActiveRecord::Base
	validates :login, uniqueness: true
	validates :login, presence: true

	def self.is_admin?(login)
		Admin.exists?(login: login)
	end
end
