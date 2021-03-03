class Api::ArticlesController < ApplicationController
  def index
    if params[:article_type]
      raw_list = Article.where(article_type: params[:article_type]).sort_by(&:created_at).reverse

      render json: raw_list, each_serializer: ArticlesIndexSerializer
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
end
