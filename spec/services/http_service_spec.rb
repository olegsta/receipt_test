# frozen_string_literal: true

# spec/services/http_service_spec.rb
require 'rails_helper'
require 'net/http'

RSpec.describe HttpService, type: :service do
  let(:url) { 'https://api.example.com/endpoint' }
  let(:headers) do
    {
      'Content-Type' => 'application/json',
      'Authorization' => 'Bearer some-token'
    }
  end
  let(:body) { { key: 'value' }.to_json }

  subject(:http_service) { described_class.new(url, headers) }

  describe '#send_post_request' do
    context 'when the request is successful' do
      let(:mock_response) { instance_double(Net::HTTPResponse, body: '{"success": true}', code: '200') }

      before do
        allow(Net::HTTP).to receive(:start).and_return(mock_response)
      end

      it 'returns the response body as a parsed JSON' do
        response = http_service.send_post_request(body)
        expect(JSON.parse(response.body)).to eq('success' => true)
      end
    end

    context 'when the request fails' do
      before do
        allow(Net::HTTP).to receive(:start).and_raise(StandardError, 'Request failed')
      end

      it 'returns nil and logs the error' do
        expect(Rails.logger).to receive(:error).with('Request failed: Request failed')
        response = http_service.send_post_request(body)
        expect(response).to be_nil
      end
    end
  end
end
