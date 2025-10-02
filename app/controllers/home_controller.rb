class HomeController < ApplicationController 
  def index
    @obligations = [
      ["Emissão DARE", "emissao_dare"]
    ]
  end
end