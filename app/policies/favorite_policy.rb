class FavoritePolicy < ApplicationPolicy

  def create?
    user.admin? || user.client?
  end

  def destroy?
    user.admin? || user.client?
  end
end