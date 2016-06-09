class MessagesController < ApplicationController
  layout 'messages'
  skip_before_action :verify_authenticity_token
  skip_before_action :auth_user!

  def index
    @messages = Message.all
  end

  def create
    @message = Message.create(messages_params)

    respond_to do |format|
      format.js
    end
  end

  private

  def messages_params
    params.require(:message).permit(:content)
  end
end
