require 'rails_helper'

RSpec.describe 'Assignments' do
  it 'allows a user to apply to a job' do
    post '/api/v1/jobs/1/assignments'
  end
end
