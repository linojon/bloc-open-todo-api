require 'spec_helper'

describe "todo", type: :feature, js: true do
  before :each do
    start_api_server
  end

  it "works" do
    #puts RestClient.get "http://127.0.0.1:3003/"
    json = RestClient.get api_url('users'), accept: :json
    data = JSON.parse json
    expect(data['users']).to include( { 'id' => 1, 'username' => 'testuser' } )
  end

end