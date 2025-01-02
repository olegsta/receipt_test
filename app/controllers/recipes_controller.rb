# frozen_string_literal: true

# app/controllers/recipes_controller.rb
class RecipesController < ApplicationController
  # POST /recipes/generate
  def generate
    ingredients = params[:ingredients]
    @recipe = 'Please provide ingredients to generate a recipe.' && return unless ingredients.present?

    recipe_service = RecipeService.new(ingredients)

    generated_recipe = recipe_service.generate_recipe
    validated_recipe = recipe_service.validate_recipe(generated_recipe) if generated_recipe

    if generated_recipe && validated_recipe
      render json: { recipe: [generated_recipe, validated_recipe] }
    else
      render json: { error: 'An error occurred while processing your request.' }, status: :internal_server_error
    end
  end
end
