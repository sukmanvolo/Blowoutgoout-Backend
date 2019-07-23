class MessagePolicy < ApplicationPolicy

  def create?
    user.admin? || user.client? || user.stylist?
  end

  def update?
    user.admin?
  end

  def destroy?
    user.admin?
  end
end