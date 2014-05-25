require 'spec_helper'

describe Api::ListsController do 
  let!(:user) { create :user }

  describe "create" do
    context "with correct user's password" do
      # it "takes a list name, creates it if it doesn't exist, and returns false if it does" do
      #   expect{ post :create, { user_id: user.id, name: 'mylist' } }
      #     .to change{ user.lists.where(name: 'mylist').count }
      #     .by 1

      #   expect(JSON.parse(response.body)).to eql params
      # end
    end

    context "without correct user's password" do
      xit "it errors"
    end
  end

  describe "index" do
    before do
      user.lists.create name: "list1", permissions: 'private'
      user.lists.create name: "list2", permissions: 'viewable'
      user.lists.create name: "list3", permissions: 'open'
    end

    context "with correct user's password" do
      it "returns all lists associated with the user" do
        get :index, { user_id: user.id, password: user.password }
        result = JSON.parse(response.body) 
        expect(result).to eql( 
          { 'lists' => 
            [
              { 'id' => 1, 'name' => 'list1', 'permissions' => 'private' },
              { 'id' => 2, 'name' => 'list2', 'permissions' => 'viewable' },
              { 'id' => 3, 'name' => 'list3', 'permissions' => 'open' }
            ]
          })
      end
    end

    context "without correct user's password" do
      it "returns all visible and open lists" do
        get :index, { user_id: user.id }
        result = JSON.parse(response.body) 
        expect(result).to eql( 
          { 'lists' => 
            [
              { 'id' => 2, 'name' => 'list2', 'permissions' => 'viewable' },
              { 'id' => 3, 'name' => 'list3', 'permissions' => 'open' }
            ]
          })

      end
    end
  end
end