class ServicePolicy < ApplicationPolicy

  def create?
    user.admin?
  end

  def update?
    user.admin?
  end

  def destroy?
    false
  end
end
