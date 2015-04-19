require 'oauth2'
require "base64"
require "http"

module EtuUtt

	class Api

		attr_accessor :client, :authorization_basic

		def initialize

			@client_id = ENV['KILLER_APP_CLIENT_ID']
			@client_secret = ENV['KILLER_APP_CLIENT_SECRET']
			@site = "https://etu.utt.fr/api/"
			@authorize_url = '/api/oauth/authorize',
		 	@token_url = '/api/oauth/token'
		 	@authorization_basic = Base64.strict_encode64(@client_id+':'+@client_secret)

		 	@client = OAuth2::Client.new(ENV['KILLER_APP_CLIENT_ID'],
					        ENV['KILLER_APP_CLIENT_SECRET'],
					        site: ENV['KILLER_APP_URI'],
					        authorize_url: '/api/oauth/authorize',
					        token_url: '/api/oauth/token')
		end

		# Url to authorize the killer app
		def authorize_url 
			return @client.auth_code.authorize_url(scopes: 'public')
		end

		# Get the token, refresh_token from an access_token
		def get_tokens(code, grant_type='authorization_code')

			params = if grant_type == 'authorization_code' 
						{ grant_type: grant_type, authorization_code: code }
					elsif grant_type == 'refresh_token' 
						{ grant_type: grant_type, refresh_token: code }
					end

			response = HTTP['Content-Type' => 'application/x-www-form-urlencoded', "Authorization" => "Basic #{@authorization_basic}"]
				.post("https://etu.utt.fr/api/oauth/token", 
					body: URI.encode_www_form(params))
		    response = JSON.parse(response.body)['response']
		    access_token = response['access_token']
	   		expires_at = response['expires_at']
	   		refresh_token = response['refresh_token']
	   		return {
	   					access_token: access_token,
	   					expires_at: expires_at,
	   					refresh_token: refresh_token
	   				} 
		end


		# render the response data of a get to the api
		def self.get(access_token, uri)
			response = HTTP.get(ENV['KILLER_APP_URI']+"public/user/account", params: {access_token: access_token}).body
			JSON.parse(response)['response']['data']
		end

	end



end
