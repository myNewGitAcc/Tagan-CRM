class RssReaderMailer < ActionMailer::Base
  default from: "noreply@taganteam.com"

  def rss_reader_changes email, response, title
    @news_feed = response
    @title = title
    mail(to: email, subject: 'Rss Reader' )
  end


end