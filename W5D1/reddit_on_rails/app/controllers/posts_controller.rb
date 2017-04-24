class PostsController < ApplicationController
  before_action :ensure_logged_in
  before_action :ensure_correct_author, only: [:edit, :update, :destroy]

  def new
    @post = Post.new
    render :new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user
    if @post.valid?
      @post.save
      redirect_to sub_url(@post.sub)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :new
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
    render :edit
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update_attributes(post_params)
      redirect_to sub_url(@post)
    else
      flash.now[:errors] = @post.errors.full_messages
      render :edit
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    redirect_to sub_url(@post)
  end

  def show
    @post = Post.find_by(id: params[:id])
    render :show
  end

  private

  def post_params
    params.require(:post).permit(:title, :url, :content, :sub_id)
  end

  def ensure_correct_author
    unless current_user == Post.find_by(id: params[:id]).author
      flash[:errors] = "You can't modify a post that is not yours!"
      redirect_to subs_url
    end
  end
end
