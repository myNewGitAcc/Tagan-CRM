ActiveAdmin.register Event do
  menu parent: "Calendars"
  config.batch_actions = false

  permit_params :title, :description, :start_time_date, :start_time_time_hour,
                :start_time_time_minute, :end_time_date, :end_time_time_hour, :end_time_time_minute

  index do
    selectable_column
    id_column
    column :title
    column :description
    column :start_time
    column :end_time
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :start_time
      row :end_time
      row :created_at
      row :updated_at
    end
  end

  form do |f|
    f.inputs "Events Details" do
      f.input :title
      f.input :description
      f.input :start_time, as: :just_datetime_picker
      f.input :end_time, as: :just_datetime_picker
    end
    f.actions
  end

end