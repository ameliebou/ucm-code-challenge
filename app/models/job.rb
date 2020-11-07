class Job < ApplicationRecord
  validates :title, presence: true
  validates :salary_per_hour, presence: true

  validates :spoken_languages, length: { minimum: 1 }
  validates :shifts, length: { minimum: 1, maximum: 7 }
end
