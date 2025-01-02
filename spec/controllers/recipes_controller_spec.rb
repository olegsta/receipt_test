# frozen_string_literal: true

# spec/controllers/recipes_controller_spec.rb
require 'rails_helper'

RSpec.describe RecipesController, type: :controller do
  let(:ingredients) { 'potatoes, butter, salt' }
  let(:generated_recipe) { 'Mashed potatoes recipe...' }
  let(:validated_recipe) { 'Mashed potatoes recipe validation...' }

  let(:recipe_service_double) { instance_double(RecipeService) }

  before do
    allow(RecipeService).to receive(:new).and_return(recipe_service_double)
  end

  describe 'POST #generate' do
    context 'when ingredients are provided' do
      before do
        allow(recipe_service_double).to receive(:generate_recipe).and_return(generated_recipe)
        allow(recipe_service_double).to receive(:validate_recipe).and_return(validated_recipe)
      end

      it 'returns a generated and validated recipe' do
        post :generate, params: { ingredients: ingredients }

        expect(response).to have_http_status(:ok)
        expect(response.body).to eq({ recipe: [generated_recipe, validated_recipe] }.to_json)
      end
    end

    context 'when ingredients are not provided' do
      it 'returns an error message' do
        post :generate, params: { ingredients: nil }

        expect(response.body).to eq('')
      end
    end

    context 'when an error occurs in the service' do
      before do
        allow(recipe_service_double).to receive(:generate_recipe).and_return(nil)
      end

      it 'returns an error message' do
        post :generate, params: { ingredients: ingredients }

        expect(response).to have_http_status(:internal_server_error)
        expect(response.body).to eq({ error: 'An error occurred while processing your request.' }.to_json)
      end
    end
  end
end
