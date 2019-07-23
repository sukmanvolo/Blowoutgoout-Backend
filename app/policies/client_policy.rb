class ClientPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def create?
    user.admin? || user.client?
  end

  def update?
  	user.admin? || user.client?
  end

  def destroy?
    user.admin? || user.client?
  end
end