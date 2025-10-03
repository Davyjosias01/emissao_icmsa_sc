class AutomationsController < ApplicationController
  def create
    obligation = params.require(:obligation)

    client = Http::BackofficeClient.new
    demands = client.demands_by_obligation( 
      obligation: obligation, 
      date_start: params[:date_start],
      date_end: params[:date_end]  
    )

    count = Array(demands).size
    redirect_to root_path, notice: "Demandas encontradas para '#{obligation}': #{count}"

  rescue RestClient::ExceptionWithResponse => e
    body = e.response&.body
    redirect_to root_path, alert: "Falha ao buscar demandas (#{e.http_code}). #{body}"
  rescue => e 
    redirect_to root_path, alert: "Erro inesperado: #{e.message}"
  end
end