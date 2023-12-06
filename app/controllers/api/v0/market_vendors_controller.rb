class Api::V0::MarketVendorsController < ApplicationController
  def index 
    # vendors = market.vendors 
    render json: market = Market.find(params[:id])
  end 
end