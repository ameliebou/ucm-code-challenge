require 'rails_helper'

RSpec.describe "Jobs requests", type: :request do
  describe 'GET /jobs' do
    before do
      job_host = Job.create(title:"Host/Hostess", salary_per_hour: 20, spoken_languages: ["english", "french"])
      Shift.create(start: DateTime.new(2020,12,01,11), end: DateTime.new(2020,12,01,16), job: job_host)
      job_kitchen = Job.create(title:"Kitchen help", salary_per_hour: 16, spoken_languages: ["german", "english"])
      Shift.create(start: DateTime.new(2020,12,03,11), end: DateTime.new(2020,12,03,15), job: job_kitchen)
      Shift.create(start: DateTime.new(2020,12,03,18), end: DateTime.new(2020,12,03,23), job: job_kitchen)
    end

    it 'returns all jobs' do
      get '/api/v1/jobs'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
    end

    it 'returns a subset of jobs based on pagination' do
      get '/api/v1/jobs', params: { limit: 1 }

      expect(response_body.size).to eq(1)
      expect(response_body.first["title"]).to eq("Host/Hostess")
    end

    it 'returns a subset of jobs with an offset' do
      get '/api/v1/jobs', params: { limit: 1, offset: 1 }

      expect(response_body.size).to eq(1)
      expect(response_body.first["title"]).to eq("Kitchen help")
    end

    it 'searches by title' do
      get '/api/v1/jobs', params: { title: 'kitchen' }
      expect(response_body.first["title"]).to eq("Kitchen help")
    end

    it 'searches by spoken language' do
      get '/api/v1/jobs', params: { spoken_language: 'german' }
      expect(response_body.first["title"]).to eq("Kitchen help")
    end

    it 'searches by title and spoken language' do
      get '/api/v1/jobs', params: { spoken_language: 'english', title: 'host' }
      expect(response_body.first["title"]).to eq("Host/Hostess")
    end
  end

  describe 'POST /jobs' do
    it 'creates a new job' do
      post '/api/v1/jobs', params: { job: {
          title: 'Promoter',
          salary_per_hour: 18.5,
          spoken_languages: [ 'english', 'german' ],
          shifts: {
            shift_one: [
              DateTime.new(2020,11,29,10),
              DateTime.new(2020,11,29,17)
            ],
            shift_two: [
              DateTime.new(2020,11,30,10),
              DateTime.new(2020,11,30,17)
            ]
          }
        },
      }
      expect(response).to have_http_status(:created)
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end
