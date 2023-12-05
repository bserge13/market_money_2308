class Api::V0::VendorsController < ApplicationController
  def show
    render json: Vendor.find(params[:id])
  end

  def create 
    render json: Vendor.create(vendor_params)
  end

  def update
    render json: Vendor.update(params[:id], vendor_params)
  end

  def destroy 
    render json: Vendor.delete(params[:id])
  end

  private 

  def vendor_params
    params.require(:vendor).permit(:name, :description, :contact_name, :contact_phone, :credit_accepted)
  end
end