module Admin::UsersHelper
  def select_role_options(user)
   options_for_select([["admin", "admin"],
                       ["manager", "manager"],
                       ["employee", "employee"]
                      ],
                       :selected => user.role
                      )
  end

  def select_manager_options(user)
    manager_list = User.where('role= ? OR role= ?', 'manager', 'admin').order(:name)
    options_from_collection_for_select(manager_list, 'id', 'name', user.manager.id)
  end
end
