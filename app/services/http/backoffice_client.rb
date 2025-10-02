require "rest-client"
require "json"

class Http::BackofficeClient
  def initialize(base_url: ENV["BASE_URL"], token: ENV["TOKEN"])
    @base_url = base_url
    @headers = {
      accept: :json,
      authorization: token
    }
  end

  def demands_by_obligation( obligation: )
    res = RestClient.get(
      "#{@base_url}/integration/v1/companies/index", { 
        params: { 
          obligation: obligation, 
          date_start: "2025-09-01", 
          date_end: "2025-10-01",
          integrated_at: "false",
          obligation_finished: "true",
          fields: "cnpj,dominio_code"
        },
        authorization: @headers[:authorization],
        accept: :json,
      }
    )
    # res = RestClient.get(
      # "#{@base_url}/integration/v1/companies/index",
      # @headers.merge(params: { obligation: obligation })
    # )
    parsed_response = JSON.parse(res.body)
    
    return parsed_response["companies"]
  end
end 