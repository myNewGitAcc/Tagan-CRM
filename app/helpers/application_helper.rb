module ApplicationHelper
  def broadcast(channel, &block)
    puts "---channel-----#{channel}"
    puts "---block-----#{block}"
    message = {channel: channel, data: capture(&block)}
    uri = URI.parse("http://localhost:9292/faye")
    puts "---message-----#{message}"
    post_form = Net::HTTP.post_form(uri, :message => message.to_json)
    puts "---post_form-----#{post_form.body}"
  end
end
