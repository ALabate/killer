class Participant < ActiveRecord::Base
	validates :login, uniqueness: true
	validates :login, :game, presence: true
	validates_with EtuUttLoginValidator, on: :create

	belongs_to :game

	has_many :hunters, class_name: 'Target', foreign_key: "hunter_id"  
	has_many :targets, class_name: 'Target', foreign_key: "pursued_id"
	
	has_paper_trail

	scope :pending, ->{ where(paid: false) }
	scope :validated, ->{ where(paid: true) }

	def to_param
		login
	end

	
end
