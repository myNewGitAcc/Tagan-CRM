module WikiPagesHelper
  acts_as_wiki_pages_helper

  def wiki_user( user )
    user ? user.full_name : "Guest"
  end

end
