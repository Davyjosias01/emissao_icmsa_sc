class OrchestratorClient
  def initialize(base_url: ORCH_CONFIG[base_url], token: ORCH_CONFIG[token])
    @base_url = base_url
    @token = token
  end

  def get_obligations( obligation: )
    puts("get_obligations")
    res = RestClient.get(
      "#{@base_url}/integration/v1/companies/index", { 
        params: { 
          obligation: obligation, 
          date_start: "2025-09-01", 
          date_end: "2025-10-01",
          integrated_at: "false",
          obligation_finished: "false"
          fields: "cnpj,dominio_code"
        },
        authorization: @token,
        accept: :json 
      }
    )
    JSON.parse(res.body)
  end
end