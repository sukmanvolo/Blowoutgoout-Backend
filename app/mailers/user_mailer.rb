class UserMailer < ApplicationMailer
  def activation_needed_email(user)
    @user = user
    @url = "http://0.0.0.0:3000/users/#{user.activation_token}/activate"
    mail(to: user.email, subject: 'Welcome to My Awesome Site')
  end

  def activation_success_email(user)
    @user = user
    @url  = 'http://0.0.0.0:3000/login'
    mail(to: user.email, subject: 'Your account is now activated')
  end

  def reset_password_email(user)
    @user = User.find user.id
    @url  = edit_password_reset_url(@user.reset_password_token)
    mail(to: user.email,
         subject: 'Your password has been reset')
  end

  def send_message(user, message)
    @user = user
    @name = user.full_name
    @name = 'No name' if @name.empty?
    @message = message
    return nil unless @user && message.present?
    mail to: ADMIN_EMAIL,
         from: user.email,
         subject: "Contact support from #{@name}"
  end
end
