module HomeHelper
  def manager_info(user)
    manager = user.manager
    if manager.present?
      "#{manager.name} (#{manager.email})".html_safe
    end
  end
end
