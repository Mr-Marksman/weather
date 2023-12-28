require 'rails_helper'

RSpec.configure do |config|
  config.swagger_root = Rails.root.join('swagger').to_s
  config.swagger_docs = {
    'swagger.yaml' => {
      openapi: '3.0.1',
      info: {
        title: 'API WEATHER',
        version: 'v0'
      },
      paths: {},
      servers: [
        {
          url: 'http://0.0.0.0:3000'
        }
      ]
    }
  }
  config.swagger_format = :yaml
end
