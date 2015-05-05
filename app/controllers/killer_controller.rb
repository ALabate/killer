class KillerController < ApplicationController

  def kill


    user = Participant.find_by_login(current_user['login'])
    target = user.target

     if target.login == params[:login]
        target.kill!
        flash[:success] = "Une confirmation de votre cible #{target.first_name} #{target.last_name} est maintenant nécessaire."
    end

    redirect_to ENV.fetch("HOST")
      
  end

end
