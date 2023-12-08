require 'rails_helper'

RSpec.describe 'Markets API' do 
  it 'can get a single market by its id' do 
    id = create(:market).id

    header = { CONTENT_TYPE: 'application/json',
    ACCEPT: 'application/json' }

    get "/api/v0/markets/#{id}", headers: header

    expect(response).to be_successful
    expect(response.status).to eq(200)

    market = JSON.parse(response.body, symbolize_names: true)

    expect(market).to be_a(Hash)
    expect(market.count).to eq(1)

    expect(market[:data][:type]).to eq('market')
    expect(market[:data]).to have_key(:attributes)
    expect(market[:data]).to have_key(:id) 
    expect(market[:data][:attributes]).to have_key(:name)
    expect(market[:data][:attributes]).to have_key(:street)
    expect(market[:data][:attributes]).to have_key(:city)
    expect(market[:data][:attributes]).to have_key(:county)
    expect(market[:data][:attributes]).to have_key(:state)
    expect(market[:data][:attributes]).to have_key(:zip)
    expect(market[:data][:attributes]).to have_key(:lat)
    expect(market[:data][:attributes]).to have_key(:lon)
  end

  it 'sad path - no market found' do
    headers = {
      CONTENT_TYPE: "application/json",
      ACCEPT: "application/json"
    }

    get '/api/v0/markets/0', headers: headers

    market = JSON.parse(response.body, symbolize_names: true)

    expect(response).to_not be_successful
    expect(response.status).to eq(404)

    expect{Market.find(0)}.to raise_error(ActiveRecord::RecordNotFound)
    expect(market[:errors][0][:detail]).to eq("Couldn't find Market with 'id'=0")
  end
end
