class AddTimestampsToRssReaders < ActiveRecord::Migration
  def change
    add_column(:rss_readers, :created_at, :datetime)
    add_column(:rss_readers, :updated_at, :datetime)
  end
end
