ActiveAdmin.register User do
  permit_params   :email,
                  :role,
                  :password,
                  :password_confirmation,
                  :first_name,
                  :last_name,
                  :admin,
                  :middle_name,
                  :date_of_birth,
                  :place_of_birth,
                  :live_in_city


  index do
    selectable_column
    id_column
    column :full_name do |user|
      "#{user.first_name} #{user.last_name}"
    end
    column :email
    column :role
    column :status
    column :admin
    column :created_at
    actions
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :date_of_birth, as: :date_picker, input_html: {min: "1950-01-01", max: "#{Date.today}" }
      f.input :place_of_birth
      f.input :live_in_city
      # render :layouts => false, :template => "map/map.html.erb"
      f.input :email
      f.input :role
      f.input :admin
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  show do
    attributes_table_for user do
      row :id
      row :last_name
      row :first_name
      row :middle_name
      row("Age"){ Time.new.year - user.date_of_birth.year }
      row :place_of_birth
      row "City" do
        render :layouts => false, :template => "map/map.html.erb"
      end
      row :email
      row :role
      row :admin

    end
  end

end