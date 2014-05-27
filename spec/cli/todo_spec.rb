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

  it "login" do
    `bin/todo login testuser secret 127.0.0.1:3003 -f test.auth`
    expect(File.read("test.auth").strip).to eql "testuser;secret;127.0.0.1:3003"
  end

  it "whoami" do
    result = `bin/todo whoami -f test.auth`
    expect(result.strip).to eql "1: testuser"
  end

end