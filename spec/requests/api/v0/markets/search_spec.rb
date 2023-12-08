require 'rails_helper'

RSpec.describe 'Search Markets' do 
  before(:each) do
    @market1 = create(:market, name:'Posey County', city: 'Evansville', state: 'Indiana')
    @market2 = create(:market, name:'Vanderburgh', city: 'Evansville', state: 'Indiana')
    @market3 = create(:market, name:'Wadesville', city: 'Evansville', state: 'Indiana')
  end

  it 'can search for markets by state, city, and name' do
    header = {
      CONTENT_TYPE: 'application/json',
      ACCEPT: 'application/json'
    }

    query_param = {
      state: 'Indiana',
      city: 'Evansville',
      name: 'Posey County'
    }

    get '/api/v0/markets/search', headers: header, params: query_param
    expect(response).to be_successful
    expect(response).to have_http_status(200)

    markets = JSON.parse(response.body, symbolize_names: true)

    expect(markets[:data].count).to eq(1)
    expect(markets[:data]).to be_an Array

    markets[:data].each do |market|
      expect(market[:id]).to eq(@market1.id.to_s)
      expect(market[:type]).to eq('market')
      expect(market[:attributes]).to be_a Hash
      expect(market[:attributes][:name]).to eq(@market1.name)
      expect(market[:attributes][:street]).to eq(@market1.street)
      expect(market[:attributes][:city]).to eq(@market1.city)
      expect(market[:attributes][:county]).to eq(@market1.county)
      expect(market[:attributes][:state]).to eq(@market1.state)
      expect(market[:attributes][:zip]).to eq(@market1.zip)
      expect(market[:attributes][:lat]).to eq(@market1.lat)
      expect(market[:attributes][:lon]).to eq(@market1.lon)
      expect(market[:attributes][:vendor_count]).to eq(@market1.vendor_count)
    end 
  end
end