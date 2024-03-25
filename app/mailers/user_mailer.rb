class UserMailer < ApplicationMailer
	default from: 'Nasser <admin@thrb.xyz>' # this domain must be verified on your MailerSend dashboard
	def welcome_email
			@user = params[:user]
			@url = 'https://mailersend.com/login'
			mail(to: [@user.email], subject: 'Hello from MailerSend!')
	end
end