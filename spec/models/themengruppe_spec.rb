require 'spec_helper'

describe Themengruppe do
 [:text, :title].each do |attr|
    it "should not be valid without #{attr}" do
      tg=FactoryGirl.build(:themengruppe, attr=>nil)
      tg.should_not be_valid
    end
  end
 
end
