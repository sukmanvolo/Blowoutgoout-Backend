class ServicePolicy < ApplicationPolicy

  def create?
    user.admin? || user.stylist?
  end

  def update?
    user.admin? || user.stylist?
  end

  def destroy?
    false
  end
end
