Rails.application.routes.draw do

	root to: 'pages#home'
	get 'sign_up', to: 'oauth2#authorize_app'
	get 'sign_in', to: 'oauth2#authorize_app'

	get 'kill/:login', to: 'killer#kill', as: :kill

	get 'oauth2/authorize_app', to: 'oauth2#authorize_app'
	get 'oauth2/callback', to: 'oauth2#callback'
	get 'oauth2/sign_out', to: 'oauth2#sign_out'

	scope "/admin", module: "admin" do
		resources :participants do 
			collection do 
				get 'killed'
				get 'alive'
			end
			member do 
				get 'targets'
			end
		end
		get '/', to: 'participants#index'
	end
end
