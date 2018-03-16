class OrderPolicy < ApplicationPolicy

  def show?
    true
  end

  def create?
    true
  end

  def destroy?
    true
  end

  def checkout?
    true
  end

  def update?
    true
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
