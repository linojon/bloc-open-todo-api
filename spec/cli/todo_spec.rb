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

  it "users" do
    User.create( username: "user2", password: "password" )
    result = `bin/todo users -f test.auth`
    expect(result).to eql( 
%Q{1: testuser
2: user2
})
  end

  it "create_user" do
    result = `bin/todo create_user myname secret -f test.auth`
    result = `bin/todo users -f test.auth`
    expect(result).to eql(
%Q{1: testuser
2: myname
})
  end

  it "lists" do
    user = User.first
    user.lists.create name: 'testlist'
    user.lists.create name: 'testlist2'

    result = `bin/todo lists -f test.auth`
    expect(result).to eql(
%Q{testlist
testlist2
})
  end

  it "create_list" do
    user = User.first
    user.lists.create name: 'testlist'
    result = `bin/todo create_list testlist9 -f test.auth`

    result = `bin/todo lists -f test.auth`
    expect(result).to eql(
%Q{testlist
testlist9
})
  end

end