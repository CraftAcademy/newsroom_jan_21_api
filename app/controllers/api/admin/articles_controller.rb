class Api::Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    raw_list = Article.where(admin: current_admin).sort_by(&:updated_at).reverse
    if raw_list == []
      render json: {
        message: "You haven't written any articles yet."
      }
    else
      render json: raw_list, each_serializer: ArticlesAdminIndexSerializer
    end
  end

  def create
    article = current_admin.articles.create(params.permit(
                                              :title, :teaser, :article_type, :category, :location, body: []
                                            ))
    if article.persisted? & attach_image(article)
      render json: {
        message: 'The article was successfully created.'
      }, status: 201
    else
      render json: {
        message: 'Please fill out all fields.'
      }, status: 422
    end
  end

  def update
    article = Article.find(params[:id])
    # article.update(params.permit(
    #                  :title, :teaser, :article_type, :category, :location, body: []
    #                ))

    if is_updated?(article) & attach_image(article)
      render json: {
        message: 'The article was successfully updated!'
      }, status: 200
    else
      render json: {
        message: 'Please fill in all the fields.'
      }, status: 422
    end
  end

  private

  def is_updated?(article)
    last_update = article[:updated_at]
    required_params = %i[title teaser body article_type category location]

    if required_params.all? { |k| params.has_key? k}
      article.update(params.permit(
                       :title, :teaser, :article_type, :category, :location, body: []
                     ))
    end

    last_update != article[:updated_at]
  end

  def attach_image(article)
    DecodeService.attach_image(params[:image], article.image) if params[:image].present?
  end
end
