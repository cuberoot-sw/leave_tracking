module LeavesHelper
  def render_links(leave)
    if leave.pending?
      if current_user.is_admin?
        content_tag(:td) { link_to 'Approve', approve_user_leafe_path(current_user, leave)} +
        content_tag(:td) { link_to 'Reject', reject_user_leafe_path(current_user, leave)} +
        if leave.user == current_user
          content_tag(:td) { link_to 'Cancel', cancel_user_leafe_path(current_user, leave)}
        end
      else
        content_tag(:td) { link_to 'Cancel', cancel_user_leafe_path(current_user, leave)}
      end
    end
  end
end
