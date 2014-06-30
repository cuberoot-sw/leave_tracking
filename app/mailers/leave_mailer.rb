class LeaveMailer < ActionMailer::Base

  def notify_pending_leave(leave, curr_user)
    @leave = leave
    @user = curr_user
    @mail_to = @user.manager
    @cc = @mail_to.manager
    @subject = "New Leave Application By- #{@user.name}"
    @from = @user.email
    setup_email(@mail_to.email, @subject, @from, @cc.email)
  end

  def notify_approved_leave(leave, curr_user)
    @leave = leave
    @user = @leave.user
    @from = curr_user.email
    @mail_to = @user.email
    @subject = "Approved Leave- #{@leave.start_date} #{@leave.end_date}"
    setup_email(@mail_to, @subject, @from)
  end

  def notify_rejected_leave(leave, curr_user)
    @leave = leave
    @user = @leave.user
    @from = curr_user.email
    @mail_to = @user.email
    @subject = "Leave Rejected- #{@leave.start_date} #{@leave.end_date}"
    setup_email(@mail_to, @subject, @from)
  end

  def notify_cancelled_leave(leave, curr_user)
    @leave = leave
    @user = curr_user
    @mail_to = @user.manager.email
    @subject = "Leave Canceled By- #{@user.name}"
    @from = @user.email
    setup_email(@mail_to, @subject, @from)
  end


  protected
    def setup_email(mail_to, subject, from, cc=false)
      mail(:to => mail_to,
           :cc => cc,
           :subject => "[CubeRoot LTS] " + subject,
           :date => Time.now,
           :from => from)
    end

end
