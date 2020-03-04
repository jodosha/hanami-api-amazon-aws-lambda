# frozen_string_literal: true

require "bundler/setup"
require "hanami/api"
require "hanami/middleware/body_parser"

class App < Hanami::API
  use Hanami::Middleware::BodyParser, :json

  get "/" do
    "Hello, World"
  end

  get "/tracks/:id" do
    "Track: #{params[:id]}"
  end

  post "/tracks" do
    status 201
    json(track: params[:track])
  end
end
