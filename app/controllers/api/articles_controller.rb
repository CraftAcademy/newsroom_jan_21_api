class Api::ArticlesController < ApplicationController
  def index
    if params[:article_type]
      articles_list = find_article_type(params[:article_type])

      render json: {
        articles: articles_list
      }
    else
      render json: {
        message: "Needs specification for type of article!"
      }
    end
  rescue ActiveRecord::StatementInvalid => error
    render json: {
      message: 'Invalid article type. Try story or experience.'
    }, status: 422
  end

  private

  def find_article_type(type)
    raw_list = Article.where(article_type: type).sort_by(&:created_at).reverse
    raw_list.map do |story|
      {
        id: story.id,
        title: story.title,
        teaser: story.teaser,
        article_type: story.article_type,
        date: story.created_at.strftime('%F')
      }
    end
  end
end
