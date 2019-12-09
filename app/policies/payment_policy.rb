class PaymentPolicy < ApplicationPolicy

  def index?
    user.admin?
  end

  def create?
    user.admin? || user.client?
  end

  def update?
    user.admin?
  end
end
