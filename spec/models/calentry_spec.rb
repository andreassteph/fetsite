require 'spec_helper'

describe Calentry do
 it "should be valid with full data" do
   e = FactoryGirl.build(:calentry)
   c = FactoryGirl.create(:calendar)
   e.calendars<<c
   e.should be_valid
 end
 [:ende,:start,:typ].each do |attr|
 it "should not be valid without #{attr}" do 
  e= FactoryGirl.build(:calentry, attr => nil)
  c=FactoryGirl.create(:calendar)
    e.calendars<<c
   e.should_not be_valid 
   e.should have_at_least(1).errors_on(attr)
 end
 end
 
end
