require "etu_utt/api"
class AddinformationToExistingParticipants < ActiveRecord::Migration
  def change

  	token = EtuUtt::Api.new.get_tokens(nil, 'client_credentials')
  	token = token[:access_token]

  	Participant.all.each do |p|
  		user = EtuUtt::Api.get(token, 'public/users/'+ p.login )
  		p.student_id = user['studentId']
  		p.first_name = user['firstName']
  		p.last_name = user['lastName']
  		p.image = user['_links'].detect{|link| link["rel"] == "user.image"}["uri"]
  		p.email = user['email']
  		p.save!
  	end
  	
  end
end
