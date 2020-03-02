# frozen_string_literal: true

require "bundler/setup"
require "hanami/api"

class App < Hanami::API
  get "/" do
    "Hello, World"
  end

  get "/tracks/:id" do
    "Track: #{params[:id]}"
  end
end
