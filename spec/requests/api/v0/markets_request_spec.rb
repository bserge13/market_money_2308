require 'rails_helper'

RSpec.describe 'Markets API' do 
  it 'sends a list of markets' do
    create_list(:market, 4)

    get '/api/v0/markets'

    expect(response).to be_successful

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets.count).to eq(4) 

    markets.each do |market| 
      expect(market).to have_key(:id) 
      expect(market[:id]).to be_an(Integer) 

      expect(market).to have_key(:name)
      expect(market[:name]).to be_a(String)

      expect(market).to have_key(:street)
      expect(market[:street]).to be_a(String) 

      expect(market).to have_key(:city)
      expect(market[:city]).to be_a(String)

      expect(market).to have_key(:county)
      expect(market[:county]).to be_a(String)

      expect(market).to have_key(:state)
      expect(market[:state]).to be_a(String)
      
      expect(market).to have_key(:zip)
      expect(market[:zip]).to be_a(String)
      
      expect(market).to have_key(:lat)
      expect(market[:county]).to be_a(String)
      
      expect(market).to have_key(:lon)
      expect(market[:lon]).to be_a(String)
    end
  end

  it 'can get a single market by its id' do 
    id = create(:market).id

    get "/api/v0/markets/#{id}"

    market = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(market).to have_key(:id) 
    expect(market[:id]).to be_an(Integer) 

    expect(market).to have_key(:name)
    expect(market[:name]).to be_a(String)

    expect(market).to have_key(:street)
    expect(market[:street]).to be_a(String) 

    expect(market).to have_key(:city)
    expect(market[:city]).to be_a(String)

    expect(market).to have_key(:county)
    expect(market[:county]).to be_a(String)

    expect(market).to have_key(:state)
    expect(market[:state]).to be_a(String)
    
    expect(market).to have_key(:zip)
    expect(market[:zip]).to be_a(String)
    
    expect(market).to have_key(:lat)
    expect(market[:county]).to be_a(String)
    
    expect(market).to have_key(:lon)
    expect(market[:lon]).to be_a(String)
  end

  it 'can get all vendors for a given market' do 
    vendor_1 = create(:vendor)
    vendor_2 = create(:vendor)
    vendor_3 = create(:vendor)

    market = create(:market)

    MarketVendor.create(market_id: market.id, vendor_id: vendor_1.id)
    MarketVendor.create(market_id: market.id, vendor_id: vendor_2.id)
    MarketVendor.create(market_id: market.id, vendor_id: vendor_3.id)

    get "/api/v0/markets/#{market.id}/vendors"
    expect(response).to be_successful
  end
end