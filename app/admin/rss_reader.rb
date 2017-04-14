ActiveAdmin.register RssReader do
  permit_params :url, :email
  config.batch_actions = false

  filter :url
  filter :email

  index do
    selectable_column
    id_column
    column :url, as: :rss
    column :email
    column :time_last_news
    actions
  end

  show do
    attributes_table do
      row :url, as: :rss
      row :email
      row :time_last_news
      row :created_at
      row :updatee_at
    end
  end

  form do |f|
    f.inputs "Rss Reader" do
      f.input :url, label: 'Rss'
      f.input :email
    end
    f.actions
  end

end
