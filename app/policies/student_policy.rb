# frozen_string_literal: true

class StudentPolicy
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

  def enrollments?
    @user.student? || school_admin?
  end

  def request_enrollment?
    @user.student?
  end

  def classmates?
    @user.student?
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
