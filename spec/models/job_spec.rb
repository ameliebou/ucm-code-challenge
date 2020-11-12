require 'rails_helper'
require 'date'

RSpec.describe Job, type: :model do
  it "validates presence of title" do
    job = Job.new
    job.title = ""
    job.valid?
    expect(job.errors[:title]).to include("can't be blank")

    job.title = "Host-ess at our event"
    job.valid?
    expect(job.errors[:title]).to_not include("can't be blank")
  end

  it "validates presence of salary_per_hour" do
    job = Job.new
    job.valid?
    expect(job.errors[:salary_per_hour]).to include("can't be blank")

    job.salary_per_hour = 15.99
    job.valid?
    expect(job.errors[:salary_per_hour]).to_not include("can't be blank")
  end

  it "must have at least 1 spoken language" do
    job = Job.new
    job.valid?
    expect(job.errors[:spoken_languages]).to include("is too short (minimum is 1 character)")

    job.spoken_languages << "english"
    job.valid?
    expect(job.errors[:spoken_languages]).to_not include("is too short (minimum is 1 character)")
  end

  describe "#total_pay" do
    it "returns the number of hours times the salary per hour" do
      job = Job.create(title:"Kitchen help", salary_per_hour: 16, spoken_languages: ["german", "english"])
      Shift.create(start: DateTime.new(2020,12,01,11), end: DateTime.new(2020,12,01,15), job: job)
      Shift.create(start: DateTime.new(2020,12,03,11), end: DateTime.new(2020,12,03,15), job: job)
      actual = job.total_pay
      expected = 112
      expect(actual).to eq(expected)
    end
  end
end
