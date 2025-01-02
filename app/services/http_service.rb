# frozen_string_literal: true

# app/services/http_service.rb
class HttpService
  def initialize(url, headers)
    @url = url
    @headers = headers
  end

  def send_post_request(body)
    uri = URI(@url)
    req = Net::HTTP::Post.new(uri, @headers)
    req.body = body

    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end
  rescue StandardError => e
    Rails.logger.error("Request failed: #{e.message}")
    nil
  end
end
