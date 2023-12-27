require 'rails_helper'
require 'webmock/rspec'

RSpec.describe AccuWeatherApiService do
  describe '.get' do
    let(:api_key) { Rails.application.credentials.accu_weather['apikey'] }
    let(:endpoint) { 'http://example.com/test' }
    let(:params) { { 'apikey' => api_key } }
    subject { described_class.get(endpoint, params) }

    context 'when the request is successful' do
      before do
        stub_request(:get, endpoint)
          .with(query: params)
          .to_return(status: 200, body: '{"example": "data"}', headers: {})
      end

      it 'returns parsed response' do
        expect(subject).to eq({ 'example' => 'data' })
      end
    end

    context 'when the request fails' do
      before do
        stub_request(:get, endpoint)
          .with(query: params)
          .to_return(status: 500, body: '{"fault": {"faultstring": "Internal Server Error"}}', headers: {})
      end

      it 'raises an error and logs the error details' do
        expect { subject }.to raise_error(RestClient::InternalServerError)
      end
    end
  end
end