module SchoolsHelper
    def school_admin_select
        Admin.where(admin_type: 1).map {|admin| [admin.full_name, admin.id] }
    end
end
