require 'rails_helper'

RSpec.describe 'MarketVendors API' do 
  before(:each) do
    @market = create(:market, name: "Chelsea Market")
    @vendor = create(:vendor, name: "Bread Alone")
  end

  it 'can create a new market_vendor' do
    header = { CONTENT_TYPE: 'application/json',
    ACCEPT: 'application/json' }

    mv_params = { market_id: @market.id, vendor_id: @vendor.id }

    expect(MarketVendor.count).to eq(0)
    post '/api/v0/market_vendors', headers: header, params: JSON.generate(mv_params)

  end
end