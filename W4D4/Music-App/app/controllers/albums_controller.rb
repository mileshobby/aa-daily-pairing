class AlbumsController < ApplicationController

  before_action :ensure_login
  
  def index
    @albums = Album.all
    render :index
  end

  def create
    @album = Album.new(album_params)
    if @album.valid?
      @album.save!
      redirect_to albums_url
    else
      flash[:errors] = ["Invalid album input!"]
      redirect_to new_band_album_url(params[:album][:band_id])
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def new
    @album = Album.new
    render :new
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update_attributes(album_params)
      redirect_to album_url(@album)
    else
      flash[:errors] = ["Invalid album input!"]
      redirect_to edit_album_url
    end
  end

  def destroy
    @album = Album.find(params[:id])
    @album.destroy
    redirect_to albums_url
  end

  private

  def album_params
    params.require(:album).permit(:name, :band_id, :version)
  end
end
