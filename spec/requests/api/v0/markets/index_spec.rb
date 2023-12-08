require 'rails_helper'

RSpec.describe 'Markets API' do 
  it 'sends a list of markets' do
    create_list(:market, 4)

    header = { CONTENT_TYPE: 'application/json',
    ACCEPT: 'application/json' }
    get '/api/v0/markets', headers: header 

    expect(response).to be_successful
    expect(response.status).to eq(200)

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets[:data].count).to eq(4) 
    
    markets[:data].each do |market| 
      expect(market).to be_an(Hash)
      expect(market).to have_key(:id)
      expect(market[:id]).to be_an(String)
      expect(market).to have_key(:type)
      expect(market[:type]).to eq('market')
      expect(market).to have_key(:attributes)

      expect(market[:attributes]).to be_a(Hash)
      expect(market[:attributes]).to have_key(:name)
      expect(market[:attributes][:name]).to be_a(String)
      expect(market[:attributes]).to have_key(:street)
      expect(market[:attributes][:street]).to be_a(String)
      expect(market[:attributes]).to have_key(:city)
      expect(market[:attributes][:city]).to be_a(String)
      expect(market[:attributes]).to have_key(:county)
      expect(market[:attributes][:county]).to be_a(String)
      expect(market[:attributes]).to have_key(:state)
      expect(market[:attributes][:state]).to be_a(String)
      expect(market[:attributes]).to have_key(:zip)
      expect(market[:attributes][:zip]).to be_a(String)
      expect(market[:attributes]).to have_key(:lat)      
      expect(market[:attributes][:lat]).to be_a(String)
      expect(market[:attributes]).to have_key(:lon)
      expect(market[:attributes][:lon]).to be_a(String)
    end
  end
end