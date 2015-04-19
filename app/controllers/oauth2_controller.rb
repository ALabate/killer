class Oauth2Controller < ApplicationController

  def authorize_app
	 redirect_to EtuUtt::Api.new.authorize_url 
  end

  def callback
   tokens = EtuUtt::Api.new.get_tokens(params[:authorization_code])
   store_tokens(tokens)
   user = current_user
   Participant.where(student_id: user['studentId'],login: user['login']).first_or_create
   redirect_to root_path
  end

  def sign_out
  	flush_tokens()
  	redirect_to root_path
  end

end
