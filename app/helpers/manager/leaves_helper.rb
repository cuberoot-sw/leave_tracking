module Manager::LeavesHelper
  def leave_approval_links(leave)
    if leave.pending?
      "#{link_to 'Show', manager_leafe_path(leave)}
       \|
      #{link_to 'Approve', approve_manager_leafe_path(leave)}
       \|
      <input type=button id=#{leave.id} class='reject_btn prompt btn' value='Reject'/>
      "
      .html_safe
    else
      "#{link_to 'Show', manager_leafe_path(leave)}".html_safe
    end
  end

  def leaves_status_links(status)
    clas_active = 'btn btn-danger'
    (link_to 'pending', manager_leaves_path(status: 'pending'), :class => (status == 'pending') ? clas_active : 'btn') +
    (link_to 'Approved', manager_leaves_path(status: 'approved'), :class => (status == 'approved') ? clas_active : 'btn') +
    (link_to 'Rejected', manager_leaves_path(status: 'rejected'), :class => (status == 'rejected') ? clas_active : 'btn')+
    (link_to 'Cancelled', manager_leaves_path(status: 'cancelled'), :class => (status == 'cancelled') ? clas_active : 'btn')
  end

end
