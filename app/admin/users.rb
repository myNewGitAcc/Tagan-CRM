ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :full_name do |user|
      "#{user.first_name} #{user.middle_name} #{user.last_name}"
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
      render :template => "map/loadScript"
      f.input :last_name
      f.input :first_name
      f.input :middle_name
      f.input :date_of_birth, as: :date_picker, input_html: {min: "1950-01-01", max: "#{Date.today}"}
      f.input :place_of_birth
      f.input :location
      f.input :email
      f.input :role
      f.input :admin
      f.has_many :technologies, heading: "Technology", allow_destroy: true do |item|
        item.input :title
        item.input :comment
      end
      f.input :password
      f.input :password_confirmation
      f.input :place_id
      f.input :location_id
    end
    f.actions
  end

  show do
    attributes_table_for user do
      render :template => "map/modal"
      row :id
      row :last_name
      row :first_name
      row :middle_name
      row("Age"){ Time.new.year - user.date_of_birth.year }
      row ("Place Of Birth") do
        render :template => "map/placeOfBirth.html.erb"
      end
      row ("City") do
        render :template => "map/location.html.erb"
      end
      row :email
      row :role
      row :admin
      row :status
      table_for user.technologies do
        column "Technologies",   :title
        column "Comment",        :comment
      end
    end
  end

  controller do
    def create
      @user = User.new(user_params)
      if @user.valid?
        @user.save
        redirect_to admin_user_path(@user)
      else
        render action: 'new'
      end
    end

    def update
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_user_path(@user)
      else
        render action: 'edit'
      end
    end

    private

    def user_params
      params.require(:user).permit(:email, :role, :password, :password_confirmation, :first_name, :last_name, :admin, :middle_name, :date_of_birth,
                                   :place_of_birth, :location, :place_id, :location_id,
                                   technologies_attributes: [:id, :title, :comment, :_destroy])
    end
  end

end