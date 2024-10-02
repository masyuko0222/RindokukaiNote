# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    @q = ReadingClub.ransack(params[:q])
    @reading_clubs = @q.result.page(params[:page]).order(updated_at: :desc)
  end
end
