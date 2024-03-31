class TestMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.test_mailer.hello.subject
  #
  default from: "admin@aqaratai.com"

  def hello
    mail(
      subject: "Hello from Aqarat AI",
      to: "nonq70007@gmail.com",
      from: "admin@aqaratai.com",
      html_body: "<strong>Hello</strong> dear Aqarat AI.",
      track_opens: "true",
      message_stream: "broadcast",
    )
  end
end
