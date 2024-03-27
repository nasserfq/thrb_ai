class UserMailer < ApplicationMailer
	default from: "admin@thrb.xyz" # this domain must be verified on your MailerSend dashboard
	def welcome_email
			@user = params[:user]
			@url = 'https://thrb.xyz'
			mail(to: [@user.email], subject: 'Hello from MailerSend!')
	end
end