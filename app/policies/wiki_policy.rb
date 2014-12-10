class WikiPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    !record.private? || (record.user == user)
  end

  def update?
    user.present? && (record.user == user || record.collaborators.include?(user) || user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    user.present? && (record.user == user || user.admin?)
  end
end
