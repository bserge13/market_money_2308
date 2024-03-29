class Api::V0::VendorsController < ApplicationController
  def show
    vendor = Vendor.find_by(id: params[:id])
    if vendor.present?
      render json: VendorSerializer.new(vendor), status: 200
    else
      render json: { "errors": [{ "detail": "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: 404
    end
  end

  def create
    vendor = Vendor.new(vendor_params)

    if vendor.save
      render json: VendorSerializer.new(vendor), status: 201
    else
      render json: { "errors": [{ "detail": "Validation failed: Contact name can't be blank, Contact phone can't be blank" }] }, status: 400
    end
  end

  def update
    vendor = Vendor.find_by(id: params[:id])
    
    if vendor.nil?
      render json: { "errors": [{ "detail": "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: 404
    elsif vendor.update(vendor_params)
      render json: VendorSerializer.new(vendor), status: 200
    else
      render json: { "errors": [{ "detail": "Validation failed: Value is missing or empty" }] }, status: 400
    end
  end

  def destroy 
    vendor = Vendor.find_by(id: params[:id])
    if vendor.present?
      vendor.destroy
    else
      render json: { "errors": [{ "detail": "Couldn't find Vendor with 'id'=#{params[:id]}" }] }, status: 404
    end
  end

  private 

  def vendor_params
    params.permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end