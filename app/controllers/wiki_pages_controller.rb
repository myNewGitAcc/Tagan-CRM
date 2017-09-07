class WikiPagesController < ApplicationController
  protect_from_forgery
  layout 'wiki'

  acts_as_wiki_pages_controller

  def create
    @page = WikiPage.create(wiki_pages_params)
    @page.update_attribute(:path, @page.id)
    redirect_to wiki_page_path(@page)
  end

  def wiki_pages_params
    params.require(:wiki_page).permit(:creator_id, :updator_id, :path, :title, :content, :created_at , :updated_at)
  end

end
