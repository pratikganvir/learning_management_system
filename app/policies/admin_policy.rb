# frozen_string_literal: true

class AdminPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def super?
    @user.admin? && @user.loginable.super_admin?
  end

  def index?
    super?
  end

  def show?
    super?
  end

  def create?
    super?
  end

  def new?
    create?
  end

  def update?
    super?
  end

  def edit?
    update?
  end

  def destroy?
    false
  end

  class Scope
    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      raise NotImplementedError, "You must define #resolve in #{self.class}"
    end

    private

    attr_reader :user, :scope
  end
end
