ActiveAdmin.register User do
  permit_params :email, :role, :password, :password_confirmation, :first_name, :last_name

  index do
    selectable_column
    id_column
    column :full_name do |user|
      "#{user.first_name} #{user.last_name}"
    end
    column :email
    column :role
    column :status
    column :created_at
    actions do |resource|
      link_to 'Calendar', "users/#{resource.id}/calendars"
    end
  end

  filter :email

  form do |f|
    f.inputs "User Details" do
      f.input :first_name
      f.input :last_name
      f.input :email
      f.input :role
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  controller do

    def update
      if params[:user][:password].blank?
        params[:user].delete("password")
        params[:user].delete("password_confirmation")
      end
      @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to admin_user_path(@user)
      else
        render action: 'edit'
      end

    end

    def user_calendar
      params[:id] = params[:id].nil? ? params[:path].split('/')[2]:params[:id]
      @user_event = UserEvent.where(user_id: params[:id])
    end

    private

      def user_params
        params.require(:user).permit(:email, :role, :password, :password_confirmation, :first_name, :last_name)
      end


  end

end