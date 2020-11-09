class Assignment < ApplicationRecord
  belongs_to :user
  belongs_to :job

  validate :user_cannot_apply_twice

  def user_cannot_apply_twice
    assignments = Assignment.where(user: user)
    assignments.select { |assignment| assignment.job == job }
    errors.add(:user, 'cannot apply twice to the same job') if assignments.length > 0
  end
end
