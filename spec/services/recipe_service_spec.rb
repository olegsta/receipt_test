# frozen_string_literal: true

# spec/services/recipe_service_spec.rb
require 'rails_helper'

RSpec.describe RecipeService, type: :service do
  let(:ingredients) { 'potatoes, butter, salt' }
  let(:mock_response) { { 'content' => [{ 'text' => 'Mashed potatoes recipe...' }] } }
  let(:http_service_double) do
    instance_double(HttpService, send_post_request: double(body: '{"content":[{"text":"Mashed potatoes recipe..."}]}'))
  end

  subject(:recipe_service) { described_class.new(ingredients) }

  before do
    # Stub the HttpService to avoid making real HTTP requests
    allow(HttpService).to receive(:new).and_return(http_service_double)
  end

  describe '#generate_recipe' do
    it 'calls the HttpService and returns the generated recipe text' do
      expect(recipe_service.generate_recipe).to eq('Mashed potatoes recipe...')
    end

    it 'returns nil if the response is nil' do
      allow(http_service_double).to receive(:send_post_request).and_return(nil)
      expect(recipe_service.generate_recipe).to be_nil
    end
  end

  describe '#validate_recipe' do
    it 'calls the HttpService and returns the validation result text' do
      expect(recipe_service.validate_recipe('Mashed potatoes recipe...')).to eq('Mashed potatoes recipe...')
    end

    it 'returns nil if the response is nil' do
      allow(http_service_double).to receive(:send_post_request).and_return(nil)
      expect(recipe_service.validate_recipe('Mashed potatoes recipe...')).to be_nil
    end
  end

  describe '#send_request' do
    it 'builds the request body and headers correctly' do
      expect(http_service_double).to receive(:send_post_request).with(anything)
      recipe_service.send(:send_request, 'Test content')
    end
  end
end
