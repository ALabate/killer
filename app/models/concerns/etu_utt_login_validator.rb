require "etu_utt/api"
class EtuUttLoginValidator < ActiveModel::Validator
  def validate(record)
  		token = EtuUtt::Api.new.get_tokens(nil, 'client_credentials')
  		token = token[:access_token]
		participant_info = record.login ? EtuUtt::Api.get(token, 'public/users/'+record.login ) : nil
		if !participant_info.present?
			record.errors[:base] << "Le login de l'etudiant n'existe pas dans la base de données du site etu"
		end
  end
end