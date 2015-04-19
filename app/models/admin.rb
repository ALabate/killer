class Admin < ActiveRecord::Base
	validates :student_id, :login, uniqueness: true
end
