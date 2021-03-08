class Api::Admin::ArticlesController < ApplicationController
  before_action :authenticate_admin!

  def index
    raw_list = Article.where(admin: current_admin)
    if raw_list == []
      render json: {
        message: "You haven't written any articles yet."
      }
    else
      render json: raw_list, each_serializer: AdminSerializer
    end
  end

  def create
    current_admin.articles.create(
      title: params[:title], teaser: params[:teaser], body: params[:body],
      article_type: params[:article_type], location: params[:location], category: params[:category]
    )
    if current_admin.articles.last.persisted?
      render json: {
        message: 'The article was successfully created.'
      }, status: 201
    else
      render json: {
        message: 'Please fill out all fields.'
      }, status: 422
    end
  end
end
