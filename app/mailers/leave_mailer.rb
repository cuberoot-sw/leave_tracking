class LeaveMailer < ActionMailer::Base

  def notify_pending_leave(leave)
    @leave = leave
    @user = @leave.user
    @mail_to = @user.manager.email
    @subject = "New Leave Application By- #{@user.name}"
    @from = @user.email
    setup_email(@mail_to, @subject, @from)
  end

  protected
    def setup_email(mail_to, subject, from)
      mail(:to => mail_to, :subject => "[CubeRoot LTS] " + subject, :date => Time.now, :from => from)
    end

end
