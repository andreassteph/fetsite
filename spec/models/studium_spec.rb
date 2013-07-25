require 'spec_helper'

describe Studium do
   it "should not be valid without name" do
    s = FactoryGirl.build(:studium, :name=>nil)
    s.should_not be_valid
    
  end
end
