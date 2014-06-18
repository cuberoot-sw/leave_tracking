class LeaveMailer < ActionMailer::Base

  def notify_pending_leave(leave)
    @leave = leave
    @user = @leave.user
    @mail_to = @user.manager.email
    @subject = "New Leave Application By- #{@user.name}"
    @from = @user.email
    setup_email(@mail_to, @subject, @from)
  end

  def notify_approved_leave(leave)
    @leave = leave
    @user = @leave.user
    @from = @user.manager.email
    @mail_to = @user.email
    @subject = "Approved Leave- #{@leave.start_date} #{@leave.end_date}"
    setup_email(@mail_to, @subject, @from)
  end

  def notify_rejected_leave(leave)
    @leave = leave
    @user = @leave.user
    @from = @user.manager.email
    @mail_to = @user.email
    @subject = "Leave Rejected- #{@leave.start_date} #{@leave.end_date}"
    setup_email(@mail_to, @subject, @from)
  end

  def notify_cancelled_leave(leave)
    @leave = leave
    @user = @leave.user
    @mail_to = @user.manager.email
    @subject = "Leave Canceled By- #{@user.name}"
    @from = @user.email
    setup_email(@mail_to, @subject, @from)
  end


  protected
    def setup_email(mail_to, subject, from)
      mail(:to => mail_to, :subject => "[CubeRoot LTS] " + subject, :date => Time.now, :from => from)
    end

end
