# frozen_string_literal: true

RSpec.describe "Request: GET /tracks/:id", type: :request do
  it "returns successful response" do
    get "/tracks/23"

    expect(last_response).to be_ok
    expect(last_response.body).to eq("Track: 23")
  end
end

RSpec.describe "Request: POST /tracks", type: :request do
  it "returns successful response" do
    post("/tracks", JSON.generate(track: payload = { title: "There is no time elsewhere" }), "CONTENT_TYPE" => "application/json")

    expect(last_response.status).to be(201)
    expect(last_response.headers["Content-Type"]).to eq("application/json")
    expect(last_response.body).to eq(JSON.generate(track: payload))
  end
end
