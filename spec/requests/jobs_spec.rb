require 'rails_helper'

RSpec.describe "Jobs API", type: :request do
  it 'returns all jobs' do
    Job.create(title:"Host/Hostess", salary_per_hour: 20, spoken_languages: ["english", "french"], shifts: [[DateTime.new(2020,11,25,11), DateTime.new(2020,11,25,15)], [DateTime.new(2020,11,25,15), DateTime.new(2020,11,25,18)]])
    Job.create(title:"Kitchen help", salary_per_hour: 16, spoken_languages: ["german", "english"], shifts: [[DateTime.new(2020,11,27,11), DateTime.new(2020,11,27,15)], [DateTime.new(2020,11,27,19), DateTime.new(2020,11,27,22)]])

    get '/api/v1/jobs'

    expect(response).to have_http_status(:success)
    expect(JSON.parse(response.body).size).to eq(2)
  end
end
