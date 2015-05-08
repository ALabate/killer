class PlayerMailer < ApplicationMailer

	def new_target_email(target)

		@hunter = target.hunter
		@target = target.pursued
		mail(to: @hunter.email, subject: 'Nouvelle cible !')
	end

	def confirm_kill_email(target)
		@hunter = target.hunter
		@target = target.pursued
		mail(to: @target.email, subject: "Confirme ta mort !")
	end

	def dead_email(target)
		@hunter = target.hunter
		@target = target.pursued
		mail(to: @target.email, subject: "Tu es mort :-(")
	end

	def opening_email(participant)
		@participant = participant
		mail(to: @participant.email, subject: "Ouverture du Killer imminente !")
	end

end
