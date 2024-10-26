
require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :request do
  let(:user) { create(:user) }


  describe 'POST #create (signup)' do
  it 'returns JWT token and user data on successful login' do
    post '/signup', :params=>{:user=>{:name=>"test",:email=>"user@test.com",:password=>"password"}}

    expect(response).to have_http_status(:ok)

    json_response = JSON.parse(response.body)

    expect(json_response['status']['code']).to eq(201)
    expect(json_response['status']['message']).to eq('Signed up successfully.')
    expect(json_response['status']['token']).not_to be_nil
    expect(response.headers['Authorization']).not_to be_nil
  end


  it 'should throw an error if the email is invalid' do
    post '/signup', :params=>{:user=>{:name=>"test",:email=>"invalid",:password=>"password"}}

    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)
    expect(json_response['status']['message']).to eq("User couldn't be created successfully. Email is invalid")

  end


  it 'should throw an error if the email is blank' do
    post '/signup', :params=>{:user=>{:name=>"test",:email=>"",:password=>"password"}}

    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)

    expect(json_response['status']['message']).to eq("User couldn't be created successfully. Email can't be blank")
    expect(json_response['status']['token']).to be_nil
    expect(response.headers['Authorization']).to be_nil
  end


  it 'should throw an error if the name is blank' do
    post '/signup', :params=>{:user=>{:name=>"",:email=>"mail@test.com",:password=>"password"}}

    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)

    expect(json_response['status']['message']).to eq("User couldn't be created successfully. Name can't be blank")
    expect(json_response['status']['token']).to be_nil
    expect(response.headers['Authorization']).to be_nil
  end



  it 'should throw an error if the password is blank' do
    post '/signup', :params=>{:user=>{:name=>"name",:email=>"mail@test.com",:password=>""}}

    expect(response).to have_http_status(422)
    json_response = JSON.parse(response.body)

    expect(json_response['status']['message']).to eq("User couldn't be created successfully. Password can't be blank")
    expect(json_response['status']['token']).to be_nil
    expect(response.headers['Authorization']).to be_nil
  end
end
end
