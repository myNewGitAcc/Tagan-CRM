include ActiveAdminHelper

ActiveAdmin.register MailServerEmails do

  before_filter :skip_sidebar!, :only => :index
 permit_params :user, :address_from, :address_to, :body

 index do
   @emails = MailServerEmails.all
   render partial: 'messages', :locals => {emails: @emails}
 end

 show do
   @email = MailServerEmails.find(params[:id])
   #@user_name = User.find(@email.user_id).full_name
   render partial: 'show_message', :locals => {email: @email, user_name: @user_name }
 end

end
