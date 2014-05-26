module LeavesHelper
  def render_links(leave)
    if current_user.is_admin?
      if leave.pending?
        content_tag(:td) { link_to 'Approve', approve_user_leafe_path(current_user, leave)} +
        content_tag(:td) { link_to 'Reject', reject_user_leafe_path(current_user, leave)}
      end +
      if leave.user == current_user
        content_tag(:td) { link_to 'Cancel', cancel_user_leafe_path(current_user, leave)}
      end
    else
      content_tag(:td) { link_to 'Cancel', cancel_user_leafe_path(current_user, leave)} +
      content_tag(:td) { link_to 'Edit', edit_user_leafe_path(current_user, leave) } +
      content_tag(:td) { link_to 'Show', user_leafe_path(current_user, leave) } +
      content_tag(:td) { link_to 'Destroy', [current_user, leave], :method => :delete, :data => { :confirm => 'Are you sure?' } }
    end
  end
end
