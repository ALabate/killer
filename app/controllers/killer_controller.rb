class KillerController < ApplicationController

  def kill


    user = Participant.find_by_login(current_user['login'])
    target = user.target

     if target.login == params[:login]
        target.kill!
        flash[:success] = "Votre cible #{target.first_name} #{target.last_name} doit confirmer que vous l'avez tué"
    end

    redirect_to ENV.fetch("HOST")
      
  end

  def confirm_my_death
	user = Participant.find_by_login(current_user['login'])
	
	if user.confirm_kill!
		flash[:success] = "Vous êtes mort. L'aventure s'arrête ici."
	end
	redirect_to ENV.fetch("HOST")
  end

  def deny_my_death
  	user = Participant.find_by_login(current_user['login'])
	
	if user.deny_kill!
		flash[:success] = "Vous êtes toujours en jeu !"
	end
	redirect_to ENV.fetch("HOST")
  end

end
