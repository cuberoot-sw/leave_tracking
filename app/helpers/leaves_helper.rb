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

  def status_links(status)
    clas_active = 'btn btn-danger'
    (link_to 'pending', leaves_path(status: 'pending'), :class => (status == 'pending') ? clas_active : 'btn') +
    (link_to 'Approved', leaves_path(status: 'approved'), :class => (status == 'approved') ? clas_active : 'btn') +
    (link_to 'Rejected', leaves_path(status: 'rejected'), :class => (status == 'rejected') ? clas_active : 'btn')+
    (link_to 'Cancelled', leaves_path(status: 'cancelled'), :class => (status == 'cancelled') ? clas_active : 'btn')
  end
end
