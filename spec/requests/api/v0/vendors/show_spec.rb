require 'rails_helper'

RSpec.describe 'Vendors API' do 
  it 'can render a single vendor by their :id' do 
    vendor = create(:vendor)

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }

    get "/api/v0/vendors/#{vendor.id}", headers: header

    expect(response).to be_successful
    expect(response.status).to eq(200)

    vendor_data = JSON.parse(response.body, symbolize_names: true)

    expect(vendor_data[:data]).to be_a Hash
    expect(vendor_data[:data]).to have_key(:id)
    expect(vendor_data[:data][:id]).to eq(vendor.id.to_s)
    expect(vendor_data[:data]).to have_key(:type)
    expect(vendor_data[:data][:type]).to eq('vendor')
    expect(vendor_data[:data]).to have_key(:attributes)

    expect(vendor_data[:data][:attributes]).to be_a Hash
    expect(vendor_data[:data][:attributes]).to have_key(:name)
    expect(vendor_data[:data][:attributes][:name]).to eq(vendor.name)
    expect(vendor_data[:data][:attributes]).to have_key(:description)
    expect(vendor_data[:data][:attributes][:description]).to eq(vendor.description)
    expect(vendor_data[:data][:attributes]).to have_key(:contact_name)
    expect(vendor_data[:data][:attributes][:contact_name]).to eq(vendor.contact_name)
    expect(vendor_data[:data][:attributes]).to have_key(:contact_phone)
    expect(vendor_data[:data][:attributes][:contact_phone]).to eq(vendor.contact_phone)
    expect(vendor[:data][:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    expect(vendor_data[:data][:attributes]).to have_key(:credit_accepted)
    expect(vendor_data[:data][:attributes][:credit_accepted]).to eq(vendor.credit_accepted)
  end
end