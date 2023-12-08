class Api::V0::MarketVendorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_response 
  rescue_from ActiveRecord::RecordInvalid, with: :validation_error_response 

  def index 
    market = Market.find(params[:market_id])
    vendors = market.vendors 
    render json: VendorSerializer.new(vendors)
  end 

  def create
    market = Market.find(params[:market_vendor][:market_id])
    vendor = Vendor.find(params[:market_vendor][:vendor_id])
    market_vendor = MarketVendor.create!(market_vendor_params)

    render json: MarketVendorSerializer.new(market_vendor), status: 201
  end

  def destroy 
    mv = MarketVendor.find 

    if mv.present? 
      mv.destroy 
      render json: {}, status: 204
    else 

    end
  end

  private 

  def market_vendor_params 
    params.require(:market_vendor).permit(:market_id, :vendor_id) 
  end 

  def not_found_response 
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 404)).serialize_json, status: :not_found 
  end

  def validation_error_response
    render json: ErrorSerializer.new(ErrorMessage.new(exception.message, 400)).serialize_json, status: :bad_request 
  end
end