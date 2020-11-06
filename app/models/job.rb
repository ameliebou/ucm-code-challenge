class Job < ApplicationRecord
  validates :title, presence: true
  validates :salary_per_hour, presence: true

  validates :spoken_languages, length: { minimum: 1 }
end
