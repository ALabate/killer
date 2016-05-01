class Oauth2Controller < ApplicationController

  def authorize_app
	 redirect_to EtuUtt::Api.new.authorize_url 
  end

  def callback
   tokens = EtuUtt::Api.new.get_tokens(params[:authorization_code])
   store_tokens(tokens)
   user = current_user
   logger.debug "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!"
   logger.debug user
   Participant.where(login: user['login']).first_or_create!( 
                                                            student_id: user['studentId'], 
                                                            email: user['email'],
                                                            first_name: user['firstName'],
                                                            last_name: user['lastName'],
                                                            image: user['_links'].detect{|link| link["rel"] == "user.image"}["uri"],
                                                            game: Game.current
                                                           )
   redirect_to ENV.fetch("HOST")
  end

  def sign_out
  	flush_tokens()
  	redirect_to ENV['HOST']
  end

end
