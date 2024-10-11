# frozen_string_literal: true

class ReadingClub < ApplicationRecord
  validates :title, presence: true
  validates :finished, inclusion: { in: [true, false] }

  has_many :participants, dependent: :destroy
  has_many :users, through: :participants

  scope :finished, -> { where(finished: true) }
  scope :open, -> { where(finished: false) }

  paginates_per 15
end