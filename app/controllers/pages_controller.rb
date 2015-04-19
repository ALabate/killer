class PagesController < ApplicationController
	
	def home
		if user_signed_in?
			@participant = Participant.find_by_login(@current_user['login'])
		end
	end
end
