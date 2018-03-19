class RestaurantPolicy < ApplicationPolicy

  def show?
    true
  end

  def location?
    true
  end




  class Scope < Scope
    def resolve
      scope.all
    end
  end
end
