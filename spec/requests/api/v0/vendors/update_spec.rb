require 'rails_helper'

RSpec.describe 'Vendors API' do 
  it 'can update an existing vendor' do 
    id = create(:vendor).id

    old_contact = Vendor.last.contact_name

    vendor_params = ({
      'contact_name': 'Kimberly Couwer',
      'credit_accepted': false
                    })
    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }            
    patch "/api/v0/vendors/#{id}", headers: header, params: JSON.generate({vendor: vendor_params})
    
    vendor = Vendor.find_by(id: id) 

    expect(response).to be_successful
    
    expect(vendor.contact_name).to_not eq(old_contact)
    expect(vendor.contact_name).to eq('Kimberly Couwer')
    expect(vendor.credit_accepted).to eq(false)
  end
end