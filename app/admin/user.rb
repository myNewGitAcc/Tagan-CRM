ActiveAdmin.register User do
  permit_params :email, :role, :password, :password_confirmation, :first_name, :last_name, :admin, :patronumic, :birthday, :city_of_birth, :city_of_residence,
                technologies_attributes: [:id, :title, :comment, :_destroy]

  index do
    selectable_column
    id_column
    column :full_name do |user|
      "#{user.first_name} #{user.last_name} #{user.patronumic}"
    end
    column :email
    column :role
    column :status
    column :created_at

    actions
  end

  filter :email
  filter :id

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :patronumic
      f.input :birthday
      f.input :city_of_birth
      f.input :city_of_residence
      f.input :email
      f.input :role
      f.has_many :technologies, heading: false, allow_destroy: true do |item|
        item.input :title
        item.input :comment
      end
      f.input :password
      f.input :password_confirmation
      f.input :admin, :label => "Administrator"
    end
    f.actions
  end


  show do
    attributes_table do
      row :id
      row :first_name
      row :last_name
      row :email
      row :role
      row :password
      row :password_confirmation
      row :encrypted_password
      row :sign_in_count
      row :status
      table_for user.technologies do
        column "Technologies",   :title
        column "Comment",        :comment
      end
    end
  end

end
ActiveAdmin.register Technology do
  belongs_to :user, optional: true
end