require 'rails_helper'

RSpec.describe 'Vendors API' do 
  it 'can update an existing vendor' do 
    id = create(:vendor).id

    old_contact = Vendor.last.contact_name

    vendor_params = {
      'contact_name': 'Kimberly Couwer',
      'credit_accepted': false
    }

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }   

    patch "/api/v0/vendors/#{id}", headers: header, params: JSON.generate(vendor_params)
    expect(response).to be_successful
    expect(response.status).to eq(200)

    vendor = Vendor.find_by(id: id) 
    
    expect(vendor.contact_name).to_not eq(old_contact)
    expect(vendor.contact_name).to eq('Kimberly Couwer')
    expect(vendor.credit_accepted).to eq(false)
  end

  it 'sad path - invlaid vendor id' do
    vendor_params = {
      'contact_name': 'Kimberly Couwer',
      'credit_accepted': false
    }

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }   

    patch "/api/v0/vendors/00", headers: headers, params: JSON.generate(vendor_params)
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    error_details = JSON.parse(response.body, symbolize_names: true)

    expect{Vendor.find(00)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(error_details[:errors][0][:detail]).to eq("Couldn't find Vendor with 'id'=00")
  end 

  it 'sad path - missing required attributes' do
    vendor = create(:vendor)
    vendor_params = {
      contact_name: nil,
      credit_accepted: false
    }

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }   

    patch "/api/v0/vendors/#{vendor.id}", headers: headers, params: JSON.generate(vendor_params)
    expect(response).to_not be_successful
    expect(response.status).to eq(400)

    error_data = JSON.parse(response.body, symbolize_names: true)

    expect(error_data).to be_a Hash
    expect(error_data).to have_key(:errors)
    expect(error_data[:errors]).to be_an Array
    expect(error_data[:errors][0]).to be_a Hash
    expect(error_data[:errors][0]).to have_key(:detail)
    expect(error_data[:errors][0][:detail]).to eq('Validation failed: Value is missing or empty')
  end 
end