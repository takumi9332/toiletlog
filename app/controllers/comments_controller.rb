class CommentsController < ApplicationController
  def create
    comment = Comment.create(comment_params)
    redirect_to "/toilets/#{comment.toilet.id}"
  end

  private
  def comment_params
    params.require(:comment).permit(:rate, :text).merge(user_id: current_user.id, toilet_id: params[:toilet_id])
  end
end
