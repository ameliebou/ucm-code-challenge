require 'rails_helper'

RSpec.describe 'Assignments requests' do
  describe 'POST /jobs/:id/assignments' do
    before do
      User.create(email: "emma.smith@test.com", password: "123456")
      job_host = Job.create(title:"Host/Hostess", salary_per_hour: 20, spoken_languages: ["english", "french"])
      Shift.create(start: DateTime.new(2020,12,01,11), end: DateTime.new(2020,12,01,16), job: job_host)
      job_kitchen = Job.create(title:"Kitchen help", salary_per_hour: 16, spoken_languages: ["german", "english"])
      Shift.create(start: DateTime.new(2020,12,03,11), end: DateTime.new(2020,12,03,15), job: job_kitchen)
      Shift.create(start: DateTime.new(2020,12,03,18), end: DateTime.new(2020,12,03,23), job: job_kitchen)
    end

    it 'allows a user to apply to a job' do
      job_id = Job.first.id
      post "/api/v1/jobs/#{job_id}/assignments", params: { user_email: User.first.email, user_token: User.first.authentication_token }
      expect(response).to have_http_status(:created)
    end

    it 'requires user to login to apply to a job' do
      job_id = Job.first.id
      post "/api/v1/jobs/#{job_id}/assignments"
      expect(response).to_not be_successful
    end

    it 'does not allow user to apply to the same job twice' do
      job_id = Job.first.id
      post "/api/v1/jobs/#{job_id}/assignments", params: { user_email: User.first.email, user_token: User.first.authentication_token }
      post "/api/v1/jobs/#{job_id}/assignments", params: { user_email: User.first.email, user_token: User.first.authentication_token }
      expect(response).to_not be_successful
    end
  end
end
