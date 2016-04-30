class Admin::AdminApplicationController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin_application'

  def home

  end

  protected

  def authenticate_admin!
    unless admin_signed_in?
      flash[:error] = "Vous n'avez pas les authorisations nécessaires pour accéder à cette page"
      redirect_to ENV['HOST']
    end
  end

  def admin_signed_in?
    user_signed_in? && Admin.is_admin?(current_user['login'])
  end

end