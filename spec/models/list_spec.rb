require 'spec_helper'

describe List do

  let(:list) { FactoryGirl.create(:list) }

  describe "validations" do
    it "validates name uniqueness" do
      list2 = List.create name: list.name
      expect(list2).to_not be_valid
      expect(list2.errors[:name]).to include 'has already been taken'
    end
  end
  
  describe "add" do
    it "adds the description to the item list" do
      expect{ list.add("New Item") }
        .to change{ list.items.where(description: 'New Item').count }
        .by 1
    end
  end

  describe "remove" do

    before { list.add("New Item") }

    it "finds by description and removes" do
      expect{ list.remove("New Item") }
        .to change{ list.items.find_by(description: "New Item").completed }
        .to true
    end

    it "returns false if nothing's there" do
      list.remove("Not There").should be_false
    end
  end
end
