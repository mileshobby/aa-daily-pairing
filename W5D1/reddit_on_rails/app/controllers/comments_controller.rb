class CommentsController < ApplicationController
  before_action :ensure_logged_in

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    if @comment.valid?
      @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] = @comment.errors.full_messages
      render :new
    end
  end

  def new
    @comment = Comment.new
    render :new
  end

  def destroy
    @comment = Comment.find_by(params[:id])
    @comment.destroy
    redirect_to post_url(@comment)
  end

  def show
    @comment = Comment.find_by(id: params[:id])
    render :show
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_comment_id)
  end
end
