class UserMailer < ApplicationMailer
	default from: "admin@aqaratai.com" # this domain must be verified on your MailerSend dashboard
	def welcome_email
			@user = params[:user]
			@url = 'https://aqaratai.com/'
			mail(to: [@user.email], subject: 'Hello from MailerSend!')
	end
end