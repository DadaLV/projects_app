module RequestHelper
  def json_response
    JSON.parse(response.body)
  rescue JSON::ParserError
    { error: "Invalid JSON response" }
  end
end
