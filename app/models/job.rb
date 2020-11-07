require "date"

class Job < ApplicationRecord
  validates :title, presence: true
  validates :salary_per_hour, presence: true

  validates :spoken_languages, length: { minimum: 1 }
  validates :shifts, length: { minimum: 1, maximum: 7 }

  def total_pay
    hours = 0
    shifts.each { |shift| hours += ((DateTime.parse(shift[1]) - DateTime.parse(shift[0])) * 24).to_i }
    return hours * salary_per_hour
  end
end
