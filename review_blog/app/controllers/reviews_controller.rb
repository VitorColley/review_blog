class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:index, :show, :top]

  def index
    @reviews = Review.includes(:item, :user).order(created_at: :desc)
  end

  def top
    @reviews = Review.order(rating: :desc, created_at: :desc).limit(20)
  end

  def show
    @comment = Comment.new
    @comments = @review.comments.includes(:user).order(created_at: :desc)
  end

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    if @review.save
      redirect_to @review, notice: "Review created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @review.update(review_params)
      redirect_to @review, notice: "Review updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @review.destroy
    redirect_to reviews_path, notice: "Review deleted!"
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:item_id, :rating, :title, :body, tag_ids: [])
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in."
    end
  end
end
