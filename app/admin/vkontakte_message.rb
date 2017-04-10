ActiveAdmin.register Message, as: 'VkontakteMessage' do
  config.batch_actions = false
  permit_params :user_ids, :message

  form do |f|
    f.inputs "Send message" do
      f.input :user_ids
      f.input :text
    end
    f.actions
  end

  controller do

    def create
      app = VkontakteApi::Client.new(ENV['access_token'])
      user_ids = params[:message][:user_ids].split(',')
      user_ids.each do |vk_id|
        app.messages.send(domain: vk_id.strip, message: params[:message][:text])
        sleep 1
      end

      redirect_to  admin_vkontakte_messages_path
    end

  end

end