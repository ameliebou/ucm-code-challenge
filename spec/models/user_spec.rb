require 'rails_helper'

RSpec.describe User, type: :model do
  it "validates presence of email" do
    user = User.new
    user.email = ''
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")

    user.email = "test@test.com"
    user.valid?
    expect(user.errors[:email]).to_not include("can't be blank")
  end

  it "validates uniqueness of email" do
    User.create(email: "test@test.com", password: "123456")
    user = User.new(email: "test@test.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "validates presence of password" do
    user = User.new
    user.password = ""
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")

    user.password = "123456"
    user.valid?
    expect(user.errors[:password]).to_not include("can't be blank")
  end
end
