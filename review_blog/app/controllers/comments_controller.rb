class CommentsController < ApplicationController
  before_action :require_login
  before_action :set_comment, only: [:destroy]
  before_action :require_owner_or_admin, only: [:destroy]

  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @review, notice: "Comment added!"
    else
      redirect_to @review, alert: "Comment cannot be empty."
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    review = @comment.review
    @comment.destroy

    redirect_to review, notice: "Comment deleted!"
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def require_owner_or_admin
    return if current_user&.admin?
    
    if @comment.user != current_user
      redirect_to @comment.review, alert: "You are not authorized to perform this action."
    end
  end

  def require_login
    unless current_user
        redirect_to login_path, alert: "Please login first."
    end
  end
  
  def comment_params
    params.require(:comment).permit(:body)
  end

end
