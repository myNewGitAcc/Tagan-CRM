module API
  module Concern::Articles
    extend ActiveSupport::Concern
    included do
      segment :article do
        desc "Create new articles"
        params do
          optional :user_id, type: Integer, desc: 'User id'
          requires :subject, type: String, desc: 'Article subject'
          requires :body, type: String, desc: 'Article body'
        end
        post do
          article_params = ActionController::Parameters.new(params).permit(:user_id, :subject, :body)
          article = Article.create(article_params)
          success! article.as_api_response(:basic), 201
        end

        desc "Return user article"
        get ':user_id' do
          articles = Article.where(user_id: params[:user_id])
          success! articles.as_api_response(:basic), 200
        end

        desc "Return articles data"
        get do
          articles = Article.all
          success! articles.as_api_response(:basic), 200
        end

        desc "update exist user"
        params do
          optional :subject, type: String, desc: "Article subject"
          optional :body, type: String, desc: "Article body"
        end
        put ":id" do
          article = Article.find_by_id params[:id]
          article_params = ActionController::Parameters.new(params).permit(:subject, :body)
          article.update_attributes(article_params)
          success! article.as_api_response(:basic), 200
        end

        desc "delete article that user"

        delete ':id' do
          articles  = Article.find_by_id params[:id]
          articles.destroy
        end

      end
    end
  end
end