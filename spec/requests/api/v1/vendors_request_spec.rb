require 'rails_helper'

describe 'Vendors API' do 
  it 'can render a single vendor by their :id' do 
    id = create(:vendor).id

    get "/api/v1/vendors/#{id}"

    vendor = JSON.parse(response.body, symbolize_names: true)

    expect(response).to be_successful

    expect(vendor).to have_key(:id)
    expect(vendor[:id]).to be_a(Integer)

    expect(vendor).to have_key(:name)
    expect(vendor[:name]).to be_a(String)

    expect(vendor).to have_key(:description)
    expect(vendor[:description]).to be_a(String) 

    expect(vendor).to have_key(:contact_name)
    expect(vendor[:contact_name]).to be_a(String)

    expect(vendor).to have_key(:contact_phone)
    expect(vendor[:contact_phone]).to be_a(String)

    expect(vendor).to have_key(:credit_accepted)
    expect(vendor[:credit_accepted]).to be_a(TrueClass).or be_a(FalseClass)
  end
end