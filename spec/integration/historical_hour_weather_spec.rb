require 'swagger_helper'

describe 'historical', swagger: true do
  path '/weather/current' do
    get 'Retrieves the current weather' do
      tags 'Current weather'
      produces 'application/json'

      response '200', 'current weather' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 temperature_value: { type: :number },
                 epoch_time: { type: :integer }
               }

        run_test!
      end
    end
  end

  path '/weather/historical' do
    get 'Retrieves historical hour weather data for last day' do
      tags 'Historical weather'
      produces 'application/json'

      response '200', 'historical hour weather data' do
        schema type: :array,
               items: {
                 type: :object,
                 properties: {
                   id: { type: :integer },
                   temperature_value: { type: :number },
                   epoch_time: { type: :integer }
                 },
                 required: ['id', 'temperature_value', 'epoch_time']
               }

        run_test!
      end
    end
  end

  path '/weather/historical/max' do
    get 'Retrieves maximum historical hour weather data' do
      tags 'Historical weather'
      produces 'application/json'

      response '200', 'maximum historical hour weather data' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 temperature_value: { type: :number },
                 epoch_time: { type: :integer }
               }

        run_test!
      end
    end
  end

  path '/weather/historical/min' do
    get 'Retrieves minimum historical hour weather data' do
      tags 'Historical weather'
      produces 'application/json'

      response '200', 'minimum historical hour weather data' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 temperature_value: { type: :number },
                 epoch_time: { type: :integer }
               }

        run_test!
      end
    end
  end

  path '/weather/historical/avg' do
    get 'Retrieves average historical hour weather data' do
      tags 'Historical weather'
      produces 'application/json'

      response '200', 'average historical hour weather data' do
        schema type: :object,
               properties: {
                 id: { type: :integer },
                 temperature_value: { type: :number },
                 epoch_time: { type: :integer }
               }

        run_test!
      end
    end
  end

  path '/weather/by_time' do
    get 'Retrieves weather data for a specific time' do
      tags 'By time weather'
      produces 'application/json'
      parameter name: :epoch_time,
                in: :query,
                type: :integer,
                default: Time.now.in_time_zone('Moscow').to_i,
                description: 'Epoch time for specific weather data',
                required: true

      response '200', 'weather data for a specific time' do
        schema type: :object,
               properties: {
                 type: { type: :string },
                 temperature_value: { type: :number },
                 epoch_time: { type: :integer }
               }

        run_test!
      end
    end

    path '/health' do
      get 'Returns health status' do
        tags 'Health'
        produces 'application/json'

        response '200', 'health status' do
          run_test!
        end
      end
    end
  end
end
