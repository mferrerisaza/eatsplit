class BillPolicy < ApplicationPolicy

  def show?
    true
  end

  def update?
    true
  end

  def create?
    !user.nil?
  end

  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
