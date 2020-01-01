class AlbumsController < ApplicationController
  before_action :set_album, only: [:show, :edit, :update, :destroy]

  # GET /albums
  # GET /albums.json
  def index
    @albums = if params[:posted_by]
      Album.where(posted_by: params[:posted_by])
           .order(rank: :desc)
           .order(:created_at)
           .page(params[:page])
           .per(10)
    else
      Album.order(rank: :desc).order(:created_at).page(params[:page]).per(7)
    end
     @posters = Album.distinct(:posted_by).pluck(:posted_by)
  end

  # GET /albums/1
  # GET /albums/1.json
  def show
  end

  # GET /albums/new
  def new
    @album = Album.new
  end

  # GET /albums/1/edit
  def edit
  end

  # POST /albums
  # POST /albums.json
  def create
    @album = Album.new(album_params)

    a = ::LinkThumbnailer.generate(@album.url)
    
    @album.image =
      a.images.nil? ? 'https://zyosui.com/wp-content/uploads/2019/09/NO-IMAGE.jpg' : a.images.first.src.to_s
    respond_to do |format|
      if @album.save
        format.html { redirect_to root_path, notice: 'Album was successfully created.' }
        format.json { render :show, status: :created, location: @album }
      else
        format.html { render :new }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /albums/1
  # PATCH/PUT /albums/1.json
  def update
    respond_to do |format|
      if @album.update(album_params)
        format.html { redirect_to root_path, notice: 'Album was successfully updated.' }
        format.json { render :show, status: :ok, location: @album }
      else
        format.html { render :edit }
        format.json { render json: @album.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /albums/1
  # DELETE /albums/1.json
  def destroy
    @album.destroy
    respond_to do |format|
      format.html { redirect_to albums_url, notice: 'Album was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_album
      @album = Album.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def album_params
      params.require(:album).permit(:rank, :url, :title, :artist_name, :description, :posted_by)
    end
end
