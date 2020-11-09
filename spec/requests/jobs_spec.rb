require 'rails_helper'

RSpec.describe "Jobs API", type: :request do
  describe 'GET /jobs' do
    before do
      Job.create(title:"Host/Hostess", salary_per_hour: 20, spoken_languages: ["english", "french"], shifts: [[DateTime.new(2020,11,25,11), DateTime.new(2020,11,25,15)], [DateTime.new(2020,11,25,15), DateTime.new(2020,11,25,18)]])
      Job.create(title:"Kitchen help", salary_per_hour: 16, spoken_languages: ["german", "english"], shifts: [[DateTime.new(2020,11,27,11), DateTime.new(2020,11,27,15)], [DateTime.new(2020,11,27,19), DateTime.new(2020,11,27,22)]])
    end

    it 'returns all jobs' do
      get '/api/v1/jobs'

      expect(response).to have_http_status(:success)
      expect(response_body.size).to eq(2)
      expect(response_body).to eq(
        [
          {
            "title"=> "Host/Hostess",
            "total_pay"=> 140.0,
            "spoken_languages"=> [
                "english",
                "french"
            ]
          },
          {
            "title"=> "Kitchen help",
            "total_pay"=> 112.0,
            "spoken_languages"=> [
                "german",
                "english"
            ]
          }
        ]
      )
    end

    it 'returns a subset of jobs based on pagination' do
      get '/api/v1/jobs', params: { limit: 1 }

      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "title"=> "Host/Hostess",
            "total_pay"=> 140.0,
            "spoken_languages"=> [
                "english",
                "french"
            ]
          }
        ]
      )
    end

    it 'returns a subset of jobs with an offset' do
      get '/api/v1/jobs', params: { limit: 1, offset: 1 }

      expect(response_body.size).to eq(1)
      expect(response_body).to eq(
        [
          {
            "title"=> "Kitchen help",
            "total_pay"=> 112.0,
            "spoken_languages"=> [
                "german",
                "english"
            ]
          }
        ]
      )
    end

    it 'searches by title' do
      get '/api/v1/jobs', params: { title: 'kitchen' }
      expect(response_body).to eq(
        [
          {
            "title"=> "Kitchen help",
            "total_pay"=> 112.0,
            "spoken_languages"=> [
                "german",
                "english"
            ]
          }
        ]
      )
    end

    it 'searches by spoken language' do
      get '/api/v1/jobs', params: { spoken_language: 'german' }
      expect(response_body).to eq(
        [
          {
            "title"=> "Kitchen help",
            "total_pay"=> 112.0,
            "spoken_languages"=> [
                "german",
                "english"
            ]
          }
        ]
      )
    end

    it 'searches by title and spoken language' do
      get '/api/v1/jobs', params: { spoken_language: 'english', title: 'host' }
      expect(response_body).to eq(
        [
          {
            "title"=> "Host/Hostess",
            "total_pay"=> 140.0,
            "spoken_languages"=> [
                "english",
                "french"
            ]
          }
        ]
      )
    end
  end

  describe 'POST /jobs' do
    it 'creates a new job' do
      post '/api/v1/jobs', params: { job: {
          title: 'Promoter',
          salary_per_hour: 18.5,
          spoken_languages: [ 'english', 'german' ],
          shifts: [[DateTime.new(2020,11,30,11), DateTime.new(2020,11,30,20)]]
        }
      }
      expect(response).to have_http_status(:created)
    end
  end

  private

  def response_body
    JSON.parse(response.body)
  end
end
