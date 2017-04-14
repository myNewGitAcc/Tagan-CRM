class CreateRssReaders < ActiveRecord::Migration
  def change
    create_table :rss_readers do |t|
      t.string    :url
      t.string    :email
      t.datetime  :time_last_news
    end
  end
end
