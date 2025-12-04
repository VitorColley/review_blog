class TagsController < ApplicationController
  def index
    @tags = Tag.order(:name)
  end

  def show
    @tag = Tag.find(params[:id])
    @reviews = @tag.reviews.order(created_at: :desc)
  end
end
