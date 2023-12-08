require 'rails_helper'

RSpec.describe 'Vendors API' do 
  it 'can delete a vendor' do 
    vendor = create(:vendor)

    expect(Vendor.count).to eq(1)
    
    header = { CONTENT_TYPE: 'application/json',
    ACCEPT: 'application/json' }

    delete "/api/v0/vendors/#{vendor.id}", headers: header
    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(Vendor.count).to eq(0)
    expect{Vendor.find(vendor.id)}.to raise_error(ActiveRecord::RecordNotFound)
  end

  it 'sad path - invalid vendor id' do
    header = { CONTENT_TYPE: 'application/json',
    ACCEPT: 'application/json' }
    
    delete "/api/v0/vendors/00", headers: header
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_details = JSON.parse(response.body, symbolize_names: true)

    expect{Vendor.find(00)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(error_details[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=00")

  end
end