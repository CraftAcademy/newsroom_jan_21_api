class Api::ArticlesController < ApplicationController
  def index
    if params[:lat] && params[:long]
      location = Geocoder.search([params[:lat], params[:long]])
      raw_list = Article.where(location: location.first.city).sort_by(&:created_at).reverse
      if raw_list == []
        raw_list = Article.all.sort_by(&:created_at).reverse
        render json: raw_list, each_serializer: ArticlesIndexSerializer,
               meta: "We found no local articles from #{location.first.city}.", meta_key: :message
      else
        render json: raw_list, each_serializer: ArticlesIndexSerializer,
               meta: "Latest articles from #{location.first.city}", meta_key: :message
      end

    elsif params[:category]
      raw_list = Article.where(category: params[:category]).sort_by(&:created_at).reverse
      if raw_list == []
        render json: { message: 'Unfortunately we did not find any articles with this category.' },
               status: 404
      else
        render json: raw_list, each_serializer: ArticlesIndexSerializer
      end

    elsif params[:article_type]
      raw_list = Article.where(article_type: params[:article_type]).sort_by(&:created_at).reverse
      render json: raw_list, each_serializer: ArticlesIndexSerializer
    else
      render json: {
        message: 'Needs specification for type of article!'
      }, status: 422
    end
  rescue NoMethodError => e
    raw_list = Article.all.sort_by(&:created_at).reverse
    render json: raw_list, each_serializer: ArticlesIndexSerializer,
           meta: "We weren't able to get your location. Enjoy our latest articles instead!", meta_key: :message
  rescue ActiveRecord::StatementInvalid => e
    render json: {
      message: 'Invalid article type. Try story or experience.'
    }, status: 422
  end

  def show
    article = Article.find(params[:id])
    render json: article, serializer: ArticlesShowSerializer
  rescue ActiveRecord::RecordNotFound => e
    render json: {
      message: 'Article not found.'
    }, status: 404
  end
end
