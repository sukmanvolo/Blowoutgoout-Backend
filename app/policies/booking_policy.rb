class BookingPolicy < ApplicationPolicy

  def index?
  	user.admin?
  end

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
    user.admin? || user.stylist?
  end

  def reject?
    update?
  end

  def complete?
    user.admin? || user.stylist?
  end
end
