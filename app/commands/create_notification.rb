class CreateNotification
  prepend SimpleCommand

  attr_accessor :owner, :message

  def initialize(owner, message)
    @owner = owner
    @message = message
  end

  def call
    Notification.create(user: owner, message: message)
  end
end