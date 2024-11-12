class UserMailerJob
  include Sidekiq::Job

  def perform(user_id)
    user = User.find(user_id)

    if user
      UserMailer.welcome_email(user).deliver_now
    else
      Rails.logger.error "User with ID #{user_id} not found"
    end
  end
end
