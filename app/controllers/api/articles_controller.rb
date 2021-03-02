class Api::ArticlesController < ApplicationController
  def index
    articles = Article.all.sort_by(&:created_at).reverse
    articles_list = articles.map do |article|
      {
        id: article.id,
        title: article.title,
        teaser: article.teaser,
        category: article.category,
        created_at: article.created_at
      }
    end
    render json: {
      articles: articles_list
    }
  end
end
