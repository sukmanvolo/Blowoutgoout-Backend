class SchedulePolicy < ApplicationPolicy

  def create?
    user.admin? || user.stylist?
  end

  def update?
    user.admin? || user.stylist?
  end

  def destroy?
    user.admin? || user.stylist?
  end
end
