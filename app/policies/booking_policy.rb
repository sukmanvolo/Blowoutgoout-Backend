class BookingPolicy < ApplicationPolicy

  def create?
    user.client?
  end

  def update?
  	user.admin? || user.client? || user.stylist?
  end

  def destroy?
    user.admin?
  end

  def confirm?
    update?
  end

  def reject?
    update?
  end

  def complete?
    user.admin? || user.stylist?
  end
end