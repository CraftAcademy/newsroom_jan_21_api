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
    article = current_admin.articles.create(permitted_params)
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
    params[:image].present? && attach_image(article)
    if article.update(permitted_params)
      render json: {
        message: 'The article was successfully updated!'
      }, status: 200
    else
      render json: {
        message: "Don't leave a field empty."
      }, status: 422
    end
  end

  private

  def permitted_params
    params.permit(
      :title, :teaser, :article_type, :category, :location, body: []
    )
  end

  def attach_image(article)
    DecodeService.attach_image(params[:image], article.image) if params[:image].present?
  end
end
