class UserMailer < ApplicationMailer
  default from: "no-reply@example.com"

  def welcome_email(user)
    @user = user

    # attachments["welcome.pdf"] = WickedPdf.new.pdf_from_string(render_to_string(pdf: "welcome", template: "user_mailer/welcome_pdf.html.erb"))
    mail(to: @user.email, subject: "Welcome to DigiStore")
  end
end
