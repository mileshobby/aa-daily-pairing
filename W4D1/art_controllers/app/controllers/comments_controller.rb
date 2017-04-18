class CommentsController < ApplicationController

  def index
    if params.has_key?(:user_id)
      user = User.find(params[:user_id])
      render json: user.comments
    elsif params.has_key?(:artwork_id)
      artwork = artwork.find(params[:artwork_id])
      render json: artwork.comments
    else
      render text: 'no comments to show'
    end
  end

  def create
    comment = Comment.new(comment_params)
    if comment.save
      render json: comment
    else
      render(
        json: comment.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.destroy
    render json: comment

  end

  private

  def comment_params
    params[:comment].permit(:body, :user_id, :artwork_id)
  end
end
