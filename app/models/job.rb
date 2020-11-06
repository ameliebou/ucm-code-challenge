class Job < ApplicationRecord
  has_many :spoken_languages
  has_many :shifts
end
