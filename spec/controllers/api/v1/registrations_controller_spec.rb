require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe "#create" do
    it "should create a user" do
      users = User.count
      post :create, params: {
        "user": {
          "email":"abc@example.com",
          "password":"password",
          "password_confirmation":"password"
         }
        }, xhr: true
      expect(User.count).to eq(users + 1)
    end
  end
end
