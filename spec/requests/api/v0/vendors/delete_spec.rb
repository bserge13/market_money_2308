require 'rails_helper'

RSpec.describe 'Vendors API' do 
  it 'can delete a vendor' do 
    vendor = create(:vendor)

    expect(Vendor.count).to eq(1)
    
    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }
    delete "/api/v0/vendors/#{vendor.id}", headers: header

    expect(response).to be_successful
    expect(response.status).to eq(204)

    expect(Vendor.count).to eq(0)
  end
end