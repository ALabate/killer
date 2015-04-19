require "etu_utt/api"
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :user_signed_in?, :store_tokens, :flush_tokens

  protected 

  def user_signed_in?
  	current_access_token != nil && current_user != nil
  end

  def current_user
  	EtuUtt::Api.get(current_access_token, 'public/user/account')
  end
  
  # Return the curent access_token or another one (trough the refresh token) if it is expired 
  def current_access_token
  	# TODO: Improve this
	#store_tokens(EtuUtt::Api.new.get_tokens(session[:refresh_token], 'refresh_token')) 
	return session[:access_token]
  end

  def store_tokens(tokens)
	session[:access_token] = tokens[:access_token]
	session[:expires_at] = tokens[:expires_at]
	session[:refresh_token] = tokens[:refresh_token]
  end

  def flush_tokens
  	session[:access_token], session[:expires_at],session[:refresh_token] = nil, nil, nil
  end

end
