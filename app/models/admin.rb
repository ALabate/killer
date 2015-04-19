class Admin < ActiveRecord::Base
	validates :student_id, uniqueness: true
	validates :student_id, presence: true

	def self.is_admin?(student_id)
		Admin.exists?(student_id: student_id)
	end
end
