class TracksController < ApplicationController
  
  before_action :ensure_login

  def index
    @tracks = Track.all
    render :index
  end

  def create
    @track = Track.new(track_params)
    if @track.valid?
      @track.save!
      redirect_to tracks_url
    else
      flash[:errors] = ["Invalid track input!"]
      redirect_to new_album_track_url(params[:track][:album_id])
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def new
    @track = Track.new
    render :new
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update_attributes(track_params)
      redirect_to track_url(@track)
    else
      flash[:errors] = ["Invalid track input!"]
      redirect_to edit_track_url
    end
  end

  def destroy
    @track = Track.find(params[:id])
    @track.destroy
    redirect_to tracks_url
  end

  private

  def track_params
    params.require(:track).permit(:title, :album_id, :track_type, :lyrics)
  end
end
