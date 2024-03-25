class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.hello.subject
  #
  default from: "admin@thrb.xyz"

  def hello
    mail(
      subject: "Hello from Thrb AI",
      to: "nonq70007@gmail.com",
      from: "admin@thrb.xyz",
      html_body: "<strong>Hello</strong> dear Thrb AI.",
      track_opens: "true",
      message_stream: "broadcast",
    )
  end
end
