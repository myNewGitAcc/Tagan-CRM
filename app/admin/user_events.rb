ActiveAdmin.register UserEvent  do
  menu false
  config.batch_actions = false
  permit_params :user_id, :event, :start, :end


  form do |f|
    f.inputs "User Event Details" do
      f.input :user_id, as: :hidden
      f.input :event, as: :select, collection: %W(#{'отпуск'} #{'отгул'} #{'прогул'}), include_blank: false
      f.input :start, as: :just_datetime_picker
      f.input :end, as: :just_datetime_picker
    end
    f.actions
  end

  controller do

    def create
      event = UserEvent.create(permitted_params[:user_event])

      redirect_to "users/#{event.user_id}/calendars"
    end

  end

end
