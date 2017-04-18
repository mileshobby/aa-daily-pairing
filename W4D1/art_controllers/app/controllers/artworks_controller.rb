class ArtworksController < ApplicationController
  # :index, :show, :update, :destroy, :create]
  def index
    if params.has_key?(:user_id)
      user = User.find(params[:user_id])
      artwork = user.artworks + user.shared_artworks
      render json: artwork
    else
      render text: 'user not found'
    end
  end

  def show
    artwork = Artwork.find(params[:id])
    render json: artwork
  end

  def update
    artwork = Artwork.find(params[:id])
    if artwork.update(artwork_params)
      render json: artwork
    else
      render(
        json: artwork.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    artwork = Artwork.find(params[:id])
    artwork.destroy
    render json: artwork
  end

  def create
    artwork = Artwork.new(artwork_params)
    if artwork.save
      render json: artwork
    else
      render(
      json: artwork.errors.full_messages, status: :unprocessable_entity
      )
    end
  end


  private
  def artwork_params
    params[:artwork].permit(:title, :image_url, :artist_id)
  end
end
