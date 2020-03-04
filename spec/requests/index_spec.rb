# frozen_string_literal: true

RSpec.describe "Request: GET /", type: :request do
  it "returns successful response" do
    get "/"

    expect(last_response).to be_ok
    expect(last_response.body).to eq("Hello, World")
  end
end
