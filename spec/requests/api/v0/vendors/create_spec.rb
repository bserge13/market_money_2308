require 'rails_helper'

RSpec.describe 'Vendors API' do 

  it 'can create a new vendor' do 
    vendor_params = ({
                    'name': 'Buzzy Bees',
                    'description': 'local honey and wax products',
                    'contact_name': 'Berly Couwer',
                    'contact_phone': '8389928383',
                    'credit_accepted': false
                  })

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }              
    post '/api/v0/vendors', headers: header, params: JSON.generate(vendor: vendor_params)

    created_vendor = Vendor.last 

    expect(response).to be_successful
    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end
end