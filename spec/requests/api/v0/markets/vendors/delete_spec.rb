require 'rails_helper'

RSpec.describe 'MarketVendors API' do 
  before(:each) do
    @market = create(:market, name: "Chelsea Market")
    @vendor = create(:vendor, name: "Bread Alone")
  end

  it '' do 
    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }

  end
end