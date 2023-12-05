class Api::V1::VendorsController < ApplicationController
  def show
    render json: Vendor.find(params[:id])
  end
end