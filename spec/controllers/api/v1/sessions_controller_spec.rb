require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :controller do
  describe "#create" do
    it "allows a user to log in" do
      User.create(email: "test@test.com", password: "123456")
      post :create, params: {
        "user": {
          "email":"test@test.com",
          "password":"123456",
         }
        }, xhr: true
      expect(JSON.parse(response.body)["messages"]).to eq("Signed In Successfully")
    end
  end
end
