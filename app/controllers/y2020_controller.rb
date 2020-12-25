# frozen_string_literal: true

class Y2020Controller < ApplicationController
  def index
    @albums =
      if params[:posted_by]
        Album.y2020.where(posted_by: params[:posted_by])
             .order(rank: :desc).order(:created_at)
             .page(params[:page]).per(10)
      else
        Album.y2020.order(rank: :desc).order(:created_at).page(params[:page]).per(7)
      end
    @posters = Album.distinct(:posted_by).pluck(:posted_by)
  end

  private

  def album_params
    params.require(:album).permit(:posted_by)
  end
end
