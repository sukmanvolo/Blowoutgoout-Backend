class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :message, :created_at

  def created_at
    object.created_at.strftime('%Y-%m-%d %H:%M')
  end
end