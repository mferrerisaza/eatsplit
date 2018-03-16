class BillPolicy < ApplicationPolicy

  def show?
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
