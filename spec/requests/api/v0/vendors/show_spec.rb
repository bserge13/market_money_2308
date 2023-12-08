require 'rails_helper'

RSpec.describe 'Vendors API' do 
  it 'can render a single vendor by their :id' do 
    id = create(:vendor).id

    header = { 'CONTENT_TYPE' => 'application/json',
    'ACCEPT' => 'application/json' }

    get "/api/v0/vendors/#{id}", headers: header

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
end