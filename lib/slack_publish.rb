class SlackPublish

  attr_reader :message, :note_text, :note_color, :channel, :notifier

  CHANNELS = {
    'general' => 'https://hooks.slack.com/services/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',
    'test' => 'https://hooks.slack.com/services/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'
  }

  def initialize message:, note_text:, note_color:, channel_name:, username: 'SlackPublish'
    @message, @note_text, @note_color = message, note_text, note_color
    @channel = CHANNELS[channel_name] || CHANNELS['general']

    @notifier = Slack::Notifier.new(@channel, username: username)
  end

  def publish
    notifier.ping message, attachments: [note]
  end

  private

  def note
    {
      fallback: note_text,
      text: note_text,
      color: note_color,
      mrkdwn_in: ["text","pretext"]
    }
  end

end
