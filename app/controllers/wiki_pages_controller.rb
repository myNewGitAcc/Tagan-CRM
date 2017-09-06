class WikiPagesController < ApplicationController
  protect_from_forgery
  layout 'wiki'
  skip_before_action :verify_authenticity_token

  acts_as_wiki_pages_controller

  def index
    @pages = WikiPage.all
    render "base_wiki_pages/all"
  end

  def new
    @page = WikiPage.new
    render "base_wiki_pages/new"
  end

  def create
    @page = WikiPage.create(wiki_pages_params)
    @page.update_attribute(:path, @page.id)
    redirect_to wiki_page_path(@page)
  end

  def show
    @page = WikiPage.find(params[:id])
    render "base_wiki_pages/show"
  end

  def destroy
    @page = WikiPage.find(params[:id])
    @page.destroy
    redirect_to wiki_all_path
  end

  def wiki_pages_params
    params.require(:wiki_page).permit(:creator_id, :updator_id, :path, :title, :content, :created_at , :updated_at)
  end

end
