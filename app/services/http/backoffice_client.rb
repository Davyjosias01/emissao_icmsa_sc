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

  def demands_by_obligation( obligation:, date_start:, date_end:, integrated_at: )
    Rails.logger.info("obligation=#{obligation} , date_start=#{date_start}")
    Rails.logger.info("data inicial do mês que vem: " + Date.today.beginning_of_month.advance(months: 1).to_s)
    
    res = RestClient.get(
      "#{@base_url}/integration/v1/companies/index",
      @headers.merge( 
        params: { 
          obligation: obligation, 
          date_start: date_start || Date.today.beginning_of_month.to_s, 
          date_end: date_end || Date.today.beginning_of_month.advance(months: 1).to_s,
          integrated_at: integrated_at || "false",
          date_start: "2025-09-01", 
          date_end: "2025-10-01",

          obligation_finished: "true",
          fields: "cnpj,dominio_code"
        }.compact
      )
    )
    # res = RestClient.get(
      # "#{@base_url}/integration/v1/companies/index",
      # @headers.merge(params: { obligation: obligation })
    # )
    parsed_response = JSON.parse(res.body)
    
    return parsed_response["companies"]
  end
end 