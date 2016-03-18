class TicketPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    #right. because viewer doesn't have to be explicitly indicated.
    #since show action just needs any role.
    user.try(:admin?) || record.project.has_member?(user)
  end

  def create?
    user.try(:admin?) || record.project.has_manager?(user) || record.project.has_editor?(user)
  end
end
