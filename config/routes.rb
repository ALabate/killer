Rails.application.routes.draw do
	root to: 'pages#home'
	get 'sign_up', to: 'oauth2#authorize_app'
	get 'sign_in', to: 'oauth2#authorize_app'

	get 'oauth2/authorize_app', to: 'oauth2#authorize_app'
	get 'oauth2/callback', to: 'oauth2#callback'
	get 'oauth2/sign_out', to: 'oauth2#sign_out'

	namespace :admin do
		get 'home', to: 'admin_application#home'
	end
end
