ActiveAdmin.register UserEvent  do
  menu false
  config.batch_actions = false
  permit_params :user_id, :event, :start, :end


  form do |f|
    f.inputs "User Event Details" do
      f.input :user_id, input_html:  { value: params[:user_id] }, as: :hidden
      f.input :event, as: :select, collection: %W(#{'отпуск'} #{'отгул'} #{'прогул'}), include_blank: false
      li class: 'select input optional', id: 'user_event_start_input' do
        label 'Start (Days-months-year - hours)', class: 'label'
        f.datetime_select :start, order: [:day, :month, :year], discard_minute: true
      end
      li class: 'select input optional', id: 'user_event_end_input' do
        label 'End (days-months-year - hours)', class: 'label'
        f.datetime_select :end, order: [:day, :month, :year], discard_minute: true
      end
    end
    f.actions
  end

  controller do

    def create
      event = UserEvent.create(permitted_params[:user_event])

      if event.errors.messages[:end].nil?
        redirect_to "/admin/users/#{event.user_id}/calendars"
      else
        flash[:error] = event.errors.messages[:end]
        redirect_to "/admin/user_events/new?user_id=#{event.user_id}"
      end
    end

  end

end
