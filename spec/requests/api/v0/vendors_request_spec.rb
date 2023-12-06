require 'rails_helper'

describe 'Vendors API' do 
  it 'can render a single vendor by their :id' do 
    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

    vendor = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful
    expect(vendor[:data]).to have_key(:id)
    expect(vendor[:data][:attributes]).to have_key(:name)
    expect(vendor[:data][:attributes]).to have_key(:description)
    expect(vendor[:data][:attributes]).to have_key(:contact_name)
    expect(vendor[:data][:attributes]).to have_key(:contact_phone)
    expect(vendor[:data][:attributes]).to have_key(:credit_accepted)
    expect(vendor[:data][:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
  end

  it 'can create a new vendor' do # check custom methods for boolean in CREATE VENDOR details 
    vendor_params = ({
                    'name': 'Buzzy Bees',
                    'description': 'local honey and wax products',
                    'contact_name': 'Berly Couwer',
                    'contact_phone': '8389928383',
                    'credit_accepted': false
                  })
    headers = { 'CONTENT_TYPE' => 'application/json' }
  
    post '/api/v0/vendors', headers: headers, params: JSON.generate(vendor: vendor_params)
    created_vendor = Vendor.last 

    expect(response).to be_successful
    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  it 'can update an existing vendor' do 
    id = create(:vendor).id

    old_contact = Vendor.last.contact_name
    old_info = Vendor.last.credit_accepted

    vendor_params = {  {
      'contact_name': 'Kimberly Couwer',
      'credit_accepted': false
  } }
    headers = { 'CONTENT_TYPE' => 'application/json' }

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate({vendor: vendor_params})
    vendor = Vendor.find_by(id: id) 


    expect(response).to be_successful
    expect(vendor.contact_name).to_not eq(old_contact)
    expect(vendor.contact_name).to eq('Kimberly Couwer')
    expect(vendor.credit_accepted).to_not eq(old_info)
    expect(vendor.credit_accepted).to eq(false)
  end

  it 'can delete a vendor' do 
    vendor = create(:vendor)

    expect(Vendor.count).to eq(1)

    delete "/api/v0/vendors/#{vendor.id}"
    expect(response).to be_successful
    expect(Vendor.count).to eq(0)
  end
end