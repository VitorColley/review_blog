class CommentsController < ApplicationController
  before_action :require_login

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

  def comment_params
    params.require(:comment).permit(:body)
  end

  def require_login
    unless current_user
        redirect_to login_path, alert: "Please login first."
  end
end
