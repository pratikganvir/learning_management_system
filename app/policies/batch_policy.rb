# frozen_string_literal: true

class BatchPolicy
  attr_reader :user, :record

  def initialize(user, record)
    @user = user
    @record = record
  end

  def school_admin?
    @user.admin? && @user.loginable.school_admin?
  end

  def index?
    school_admin?
  end

  def show?
    school_admin?
  end

  def create?
    school_admin?
  end

  def new?
    school_admin?
  end

  def update?
    school_admin?
  end

  def edit?
    update?
  end

  def destroy?
    school_admin?
  end

  def add_courses?
    school_admin?
  end

  def create_courses?
    school_admin?
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
