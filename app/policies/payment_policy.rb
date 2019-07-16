class PaymentPolicy < ApplicationPolicy

  def create?
    user.admin? || user.client?
  end

  def update?
    user.admin?
  end
end