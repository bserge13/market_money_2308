require 'rails_helper'

RSpec.describe 'Markets API' do 
  it 'can get all vendors for a given market' do 
    market = create(:market)
    
    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    MarketVendor.create(market_id: market.id, vendor_id: vendor_1.id)
    MarketVendor.create(market_id: market.id, vendor_id: vendor_2.id)
    MarketVendor.create(market_id: market.id, vendor_id: vendor_3.id)

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }

    get "/api/v0/markets/#{market.id}/vendors", headers: header
    expect(response).to be_successful
    expect(response.status).to eq(200)    

    vendors = JSON.parse(response.body, symbolize_names: true)
    
    expect(vendors[:data].count).to eq(3) 
    
    vendors[:data].each do |vendor| 
      expect(vendor).to have_key(:id)
      expect(vendor[:id]).to be_a(String)
      expect(vendor).to have_key(:type)
      expect(vendor[:type]).to eq('vendor')

      expect(vendor[:attributes]).to be_a Hash
      expect(vendor[:attributes]).to have_key(:name)
      expect(vendor[:attributes][:name]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:description)
      expect(vendor[:attributes][:description]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:contact_name)
      expect(vendor[:attributes][:contact_name]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:contact_phone)
      expect(vendor[:attributes][:contact_phone]).to be_a(String)
      expect(vendor[:attributes]).to have_key(:credit_accepted)
      expect(vendor[:attributes][:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
    end
  end

  it 'sad path: market does not exist' do
    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }

    get "/api/v0/markets/00/vendors", headers: header
    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    market = JSON.parse(response.body, symbolize_names: true)

    expect{Market.find(00)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(market[:errors][0][:detail]).to eq("Couldn't find Market with 'id'=00")

  end
end