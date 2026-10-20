class RegistrationMailer < ApplicationMailer
  def welcome_email(user)
    @user = user

    mail(
      to: @user.email,
      from: "userfrom@email.com",
      bcc: "usercopy@email.com",
      reply_to: "userreply@email.com",
      subject: "Welcome to the Job"
      )
  end
end
