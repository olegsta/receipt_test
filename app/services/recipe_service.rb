# frozen_string_literal: true

# app/services/recipe_service.rb
class RecipeService
  GENERATE_RECIPE_PROMPT = 'Generate a couple recipes with the following ingredients: '
  VALIDATE_RECIPE_PROMPT = "Is this text a valid recipe?\n"

  def initialize(ingredients)
    @ingredients = ingredients
    @api_url = Rails.application.credentials.dig(:anthropic, :api_url)
    @api_model = Rails.application.credentials.dig(:anthropic, :api_model)
    @api_key = Rails.application.credentials.dig(:anthropic, :api_key)
  end

  def generate_recipe
    response = send_request("#{GENERATE_RECIPE_PROMPT}#{@ingredients}")
    extract_text_from_response(response)
  end

  def validate_recipe(recipe_text)
    response = send_request("#{VALIDATE_RECIPE_PROMPT}#{recipe_text}")
    extract_text_from_response(response)
  end

  private

  def send_request(content)
    headers = build_headers
    http_service = HttpService.new(@api_url, headers)
    response = http_service.send_post_request(build_request_body(content))
    parse_response(response)
  end

  def build_headers
    {
      'x-api-key' => @api_key,
      'anthropic-version' => '2023-06-01',
      'content-type' => 'application/json'
    }
  end

  def build_request_body(content)
    {
      model: @api_model,
      max_tokens: 1024,
      messages: [{ role: 'user', content: content }]
    }.to_json
  end

  def parse_response(response)
    return nil unless response

    JSON.parse(response.body)
  rescue JSON::ParserError => e
    Rails.logger.error("Failed to parse response: #{e.message}")
    nil
  end

  def extract_text_from_response(response)
    response ? response['content'].first['text'] : nil
  end
end
