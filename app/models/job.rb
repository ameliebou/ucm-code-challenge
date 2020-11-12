require "date"

class Job < ApplicationRecord
  has_many :assignments
  has_many :shifts

  validates :title, presence: true
  validates :salary_per_hour, presence: true

  validates :spoken_languages, length: { minimum: 1 }

  include PgSearch::Model
  pg_search_scope :search_by_title,
    against: [ :title ],
    using: {
      tsearch: { prefix: true }
    }

  pg_search_scope :search_by_spoken_language,
    against: [ :spoken_languages ],
    using: {
      tsearch: { prefix: true }
    }

  def total_pay
    hours = 0
    shifts.each { |shift| hours += ((DateTime.parse(shift[1]) - DateTime.parse(shift[0])) * 24).to_i }
    return hours * salary_per_hour
  end
end
