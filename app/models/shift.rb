class Shift < ApplicationRecord
  belongs_to :job

  validates :start, :end, presence: true
end
