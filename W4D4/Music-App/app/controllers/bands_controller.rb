class BandsController < ApplicationController
  
  before_action :ensure_login

  def index
    @bands = Band.all
    render :index
  end

  def create
    @band = Band.new(band_params)
    if @band.valid?
      @band.save
      redirect_to band_url(@band)
    else
      flash[:errors] = ["Band must have a name"]
      redirect_to new_band_url
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def new
    @band = Band.new
    render :new
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update_attributes(band_params)
      redirect_to band_url(@band)
    else
      flash[:errors] = ["Incorrect input!"]
      redirect_to edit_band_url(@band)
    end
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end
