Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :weather do
    get 'current', to: 'current_weather#show'

    namespace :historical do
      get '', to: 'historical_hour_weather#index'
      get 'max', to: 'historical_hour_weather#max'
      get 'min', to: 'historical_hour_weather#min'
      get 'avg', to: 'historical_hour_weather#avg'
    end

    get 'by_time', to: 'by_time_weather#show'
  end

  get 'health', to: 'health#health'
end