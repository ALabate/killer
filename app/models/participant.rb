class Participant < ActiveRecord::Base
	validates :student_id, :login, uniqueness: true
	validates :student_id, :login, presence: true

end
