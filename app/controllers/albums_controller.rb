# frozen_string_literal: true

class AlbumsController < ApplicationController
  before_action :set_album, only: %i[show edit update destroy]

  def index
    @albums =
      if params[:posted_by]
        Album.where(posted_by: params[:posted_by])
             .order(rank: :desc).order(:created_at)
             .page(params[:page]).per(10)
      else
        Album.order(rank: :desc).order(:created_at).page(params[:page]).per(7)
      end
    @posters = Album.distinct(:posted_by).pluck(:posted_by)
  end

  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)

    a = ::LinkThumbnailer.generate(@album.url)

    @album.image =
      a.images.nil? ? 'https://zyosui.com/wp-content/uploads/2019/09/NO-IMAGE.jpg' : a.images.first.src.to_s
    if @album.save
      redirect_to root_path, notice: 'Album was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @album.update(album_params)
      redirect_to root_path, notice: 'Album was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @album.destroy
    redirect_to albums_url, notice: 'Album was successfully destroyed.'
  end

  private

  def set_album
    @album = Album.find(params[:id])
  end

  def album_params
    params.require(:album).permit(:rank, :url, :title, :artist_name, :description, :posted_by)
  end
end
