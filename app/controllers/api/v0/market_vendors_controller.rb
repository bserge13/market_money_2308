class Api::V0::MarketVendorsController < ApplicationController
  def index 
    market = Market.find_by(id: params[:market_id])

    if market.present?
      render json: VendorSerializer.new(market.vendors), status: 200
    else 
      render json: { "errors": [{ "detail": "Couldn't find Market with 'id'=#{params[:market_id]}" }] }, status: 404
    end 
  end 

  def create
    market = Market.find(params[:market_vendor][:market_id])
    vendor = Vendor.find(params[:market_vendor][:vendor_id])
    market_vendor = MarketVendor.new(market_id: market.id, vendor_id: vendor.id)
    
    if market_vendor.save
      render json: { "message": "Successfully added #{vendor.name} to #{market.name}" }, status: 201
    elsif market.nil? || vendor.nil?
      render json: { "errors": [{ "detail": "Validation failed: market or vendor does not exist" }] }, status: 404
    else
      render json: { "errors": [{ "detail": "Validation failed: Market vendor asociation between market with market_id=#{market.id} and vendor_id=#{vendor.id} already exists" }] }, status: 422
    end
  end

  def destroy 
    mv = MarketVendor.find_by(market_id: params[:market_id], vendor_id: params[:vendor_id])

    if mv.present? 
      mv.destroy 
      render json: {}, status: 204
    else 
      render json: { "errors": [{ "detail": "No MarketVendor with market_id=#{params[:market_id]} AND vendor_id=#{params[:vendor_id]} exists" }] }, status: 404
    end
  end
end