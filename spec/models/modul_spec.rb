require 'spec_helper'

describe Modul do
  it "should not be valid without name" do
    m = FactoryGirl.build(:modul)
    m.should_not be_valid
    m.should have(1).errors_on(:name)
  end
  it "should be valid with name" do
    m = FactoryGirl.build(:modul)
    m.name = "Grundlagen"
    m.should be_valid
  end
end
