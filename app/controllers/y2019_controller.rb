# frozen_string_literal: true

class Y2019Controller < ApplicationController
  def index
    @albums =
      if params[:posted_by]
        Album.y2019.where(posted_by: params[:posted_by])
             .order(rank: :desc).order(:created_at)
             .page(params[:page]).per(10)
      else
        Album.y2019.order(rank: :desc).order(:created_at).page(params[:page]).per(7)
      end
    @posters = Album.y2019.distinct(:posted_by).pluck(:posted_by)
  end

  private

  def album_params
    params.require(:album).permit(:posted_by)
  end
end
