require 'rails_helper'

RSpec.describe Api::V1::JobsController, type: :controller do
  it "has a max limit of 20" do
    expect(Job).to receive(:limit).with(20).and_call_original

    get :index, params: { limit: 100 }, xhr: true
  end
end
