class Api::V0::VendorsController < ApplicationController
  def show
    render json: VendorSerializer.new(Vendor.find(params[:id]))
  end

  def create 
    render json: VendorSerializer.new(Vendor.create(vendor_params))
  end

  def update
    render json: VendorSerializer.new(Vendor.update(params[:id], vendor_params))
  end

  def destroy 
    render json: VendorSerializer.new(Vendor.destroy(params[:id]))
  end

  private 

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end