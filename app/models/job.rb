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
    shifts.each { |shift| hours += ((DateTime.parse(shift.end.to_s) - DateTime.parse(shift.start.to_s)) * 24).to_i }
    return hours * salary_per_hour
  end

  def valid_shifts?
    if shifts.count > 0 && shifts.count <= 7
      return true
    else
      errors.add(:shifts, "must be between 1 and 7")
      return false
    end
  end
end
