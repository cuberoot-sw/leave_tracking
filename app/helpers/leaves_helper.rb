module LeavesHelper
  def render_links(leave)
    if leave.pending?
      content_tag(:td) { link_to 'Show', user_leafe_path(current_user, leave) } +
      content_tag(:td) { link_to 'Edit', edit_user_leafe_path(current_user, leave) } +
      content_tag(:td) { link_to 'Cancel', cancel_user_leafe_path(current_user, leave)}
    else
      content_tag(:td) { link_to 'Show', user_leafe_path(current_user, leave) }
    end
  end
end
