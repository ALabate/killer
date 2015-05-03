class Participant < ActiveRecord::Base
	validates :login, uniqueness: true
	validates :login, :game, presence: true
	validates_with EtuUttLoginValidator, on: :create

	belongs_to :game

	#has_many :hunters, :through => :hunter, :source => :target
	#has_many :targets, :through => :pursu, :source => :target

	has_many :targets, foreign_key: "hunter_id", class_name: 'Target'
	has_many :hunters, foreign_key: "pursued_id", class_name: 'Target'

	has_many :targeter_players, through: :hunters, source: :hunter
	has_many :targeted_players, through: :targets, source: :pursued
	
	has_paper_trail

	scope :pending, ->{ where(paid: false) }
	scope :validated, ->{ where(paid: true) }

	def to_param
		login
	end

	def target 
		targeted_players.first
	end

	def hunter 
		targeter_players.first
	end
	
end
