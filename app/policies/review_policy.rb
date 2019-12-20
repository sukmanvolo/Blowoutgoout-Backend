class ReviewPolicy < ApplicationPolicy

  attr_reader :user

  def initialize(user, record)
    @user = user
  end

  def index?
    user.admin? || user.client?
  end

  def create?
    user.admin? || user.client?
  end

  def destroy?
    user.admin? || user.client?
  end
end
