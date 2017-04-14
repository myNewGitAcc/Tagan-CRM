class RssReaderMailer < ActionMailer::Base
  default from: "rss@taganteam.com"

  def rss_reader_changes email, response, title
    @news_feed = response
    @title = title
    mail(to: email, subject: 'News Feed')
  end


end