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
end
