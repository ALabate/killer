require "etu_utt/api"
class EtuUttLoginValidator < ActiveModel::Validator
  def validate(record)
  		token = EtuUtt::Api.new.get_tokens(nil, 'client_credentials')
  		token = token[:access_token]
		participant_info = EtuUtt::Api.get(token, 'public/users/'+record.login )
		if !participant_info.present?
			record.errors[:base] << "Le login n'existe pas dans la base de données des étudiants"
		end
  end
end