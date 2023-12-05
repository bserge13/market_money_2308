require 'rails_helper'

describe 'Vendors API' do 
  it 'can render a single vendor by their :id' do 
    id = create(:vendor).id

    get "/api/v0/vendors/#{id}"

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

  it 'can create a new vendor' do
    vendor_params = ({
                    :name=>"Settle Downnn",
                    :description=>
                    "These tomatos? Fuggetaboutit",
                    :contact_name=>"Ronnell Fair",
                    :contact_phone=>"123-456-7890",
                    :credit_accepted=>true
                  })
    headers = { "CONTENT_TYPE" => "application/json" }
  
    post '/api/v0/vendors/', headers: headers, params: JSON.generate(vendor: vendor_params)
    created_vendor = Vendor.last 

    expect(response).to be_successful
    expect(created_vendor.name).to eq(vendor_params[:name])
    expect(created_vendor.description).to eq(vendor_params[:description])
    expect(created_vendor.contact_name).to eq(vendor_params[:contact_name])
    expect(created_vendor.contact_phone).to eq(vendor_params[:contact_phone])
    expect(created_vendor.credit_accepted).to eq(vendor_params[:credit_accepted])
  end

  it 'can update an existing vendor' do 
    id = create(:vendor).id
    old_name = Vendor.last.name
    vendor_params = { name: "Bobs Burgers' Produce"}
    headers = { "CONTENT_TYPE" => "application/json" }

    patch "/api/v0/vendors/#{id}", headers: headers, params: JSON.generate({vendor: vendor_params})
    vendor = Vendor.find_by(id: id) 


    expect(response).to be_successful
    expect(vendor.name).to_not eq(old_name)
    expect(vendor.name).to eq("Bobs Burgers' Produce")

  end
end