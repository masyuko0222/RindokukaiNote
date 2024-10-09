# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    # 初期表示、または参加(取消)ボタンを押した時は、開催中かつ１ページ目を表示するようにする
    params[:q] ||= { finished_eq: false }

    @q = ReadingClub.ransack(params[:q])

    clubs = (current_user.participating_open_clubs + @q.result.order(:updated_at)).uniq(&:id)

    @reading_clubs = Kaminari.paginate_array(clubs).page(params[:page])
  end
end
