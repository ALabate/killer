class PlayerMailer < ApplicationMailer

	def new_target_email(target)

		@hunter = target.hunter
		@target = target.pursued
		mail(to: @hunter.email, subject: 'Une nouvelle cible !')
	end

	def confirm_kill_email(target)
		@hunter = target.hunter
		@target = target.pursued
		mail(to: @target.email, subject: "On dirait que l'on t'a tué")
	end

	def dead_email(target)
		@hunter = target.hunter
		@target = target.pursued
		mail(to: @target.email, subject: "Tu es mort :-(")
	end

end
