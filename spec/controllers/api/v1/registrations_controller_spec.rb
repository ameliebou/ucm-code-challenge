require 'rails_helper'

RSpec.describe Api::V1::RegistrationsController, type: :controller do
  describe "#create" do
    it "should create a user" do
      get :create, params: {
        "user": {
          "email":"abc@example.com",
          "password":"password",
          "password_confirmation":"password"
         }
        }, xhr: true
    end
  end
end
