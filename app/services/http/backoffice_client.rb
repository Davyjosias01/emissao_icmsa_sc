require "rest-client"
require "json"

class Http::BackofficeClient
  def initialize(base_url: ORCH_CONFIG["BASE_URL"], token: ORCH_CONFIG["TOKEN"])
    @base_url = base_url
    @headers = {
      accept: :json.
      authorization: token.present? ? token : nil
    }.compact
  end

  def demands_by_obligation(obligation:)
    res = RestClient.get(
      "#{base_url}/integration/v1/companies/index",
      @headers.merge(params: { obligation: obligation })
    )
    JSON.parse(res.body)
  end
end