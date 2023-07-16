class Admin < ApplicationRecord
    enum :admin_type, [:super_admin, :school_admin]
    has_one :login, as: :loginable
    has_one :school
    accepts_nested_attributes_for :login, allow_destroy: true

    def full_name
        "#{first_name} #{last_name}"
    end
end
