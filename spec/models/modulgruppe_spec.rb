require 'spec_helper'

describe Modulgruppe do
  it "should not be valid without studium" do
  mg=FactoryGirl.build(:modulgruppe)
  mg.should_not be_valid
  mg.should have(1).errors_on(:studium_id)
  end 
  it "should be valid with studium" do
  s=FactoryGirl.create(:studium)
  mg=FactoryGirl.build(:modulgruppe)
  mg.studium=s
  mg.should be_valid
  end   
  it "should not be valid without name" do
  s=FactoryGirl.create(:studium)
  mg=FactoryGirl.build(:modulgruppe)
  mg.studium=s
  mg.name=nil
  mg.should_not be_valid
  mg.should have_at_least(1).errors_on(:name)
  end 
  xit "should not be valid with dubble name" do
  s=FactoryGirl.create(:studium)
  mg=FactoryGirl.build(:modulgruppe, name: "Gruppe 1", desc: "132")
  mg.studium=s
  mg.save
  mg=FactoryGirl.build(:modulgruppe, name: "Gruppe 2", desc: "133")
  mg.studium=s
  mg.should_not be_valid
  mg.should have_at_least(1).errors_on(:name)
  end    
  
  it "should be valid with same name on different studien" do
  s=FactoryGirl.create(:studium)
  s2=FactoryGirl.create(:other_studium)
  mg=FactoryGirl.build(:modulgruppe, name: "Gruppe")
  mg.studium=s
  mg.save
  mg=FactoryGirl.build(:other_modulgruppe, name: "Gruppe")
  mg.studium=s2
  mg.should be_valid

  end    
  
end
