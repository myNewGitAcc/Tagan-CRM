ActiveAdmin.register MailServerEmails do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
 permit_params :user, :address_from, :address_to, :body

 index do
   selectable_column
   id_column
   column :user
   column :address_from
   column :address_to
   column :body
   actions
 end

 filter :address_to

end
