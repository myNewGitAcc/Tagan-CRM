class SupportMailer < ActionMailer::Base
  default from: "support@taganteam.com"

  def send_dump file_name, date
    attachments[file_name] = File.read('public/dump')
    mail(:to => "#{ENV['SUPPORT_EMAIL']}", :subject => "TaganCRM Dump #{date}")
  end

end
