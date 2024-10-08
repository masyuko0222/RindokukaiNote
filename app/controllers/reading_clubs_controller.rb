# frozen_string_literal: true

class ReadingClubsController < ApplicationController
  def index
    # 初期表示は開催中のものの１ページ目を表示するようにする
    # 参加ボタン押下後もparamsが空になることで、自動的に開催中の１ページ目に戻るようにし、ちゃんと参加できているか分かりやすくする
    params[:q] ||= { finished_eq: false }

    @q = ReadingClub.ransack(params[:q])

    a = current_user.open_participating_reading_clubs + @q.result.order(updated_at: :desc)

    @reading_clubs = Kaminari.paginate_array(a.uniq(&:id)).page(params[:page])
  end
end
