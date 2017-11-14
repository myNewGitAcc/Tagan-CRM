module ActiveAdminHelper
  def find_user_name_by_id(user_id)
    User.find(user_id).full_name
  end
end
