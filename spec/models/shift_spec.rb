require 'rails_helper'
require 'date'

RSpec.describe Shift, type: :model do
  it "must have a start and an end" do
    shift = Shift.new
    shift.valid?
    expect(shift.errors[:start]).to include("can't be blank")
    expect(shift.errors[:end]).to include("can't be blank")

    shift.start = DateTime.new(2020,12,01,11)
    shift.end = DateTime.new(2020,12,01,13)
    shift.valid?
    expect(shift.errors[:start]).to_not include("can't be blank")
    expect(shift.errors[:end]).to_not include("can't be blank")
  end
end
