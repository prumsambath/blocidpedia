class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private? || (record.user == user)
  end
end
