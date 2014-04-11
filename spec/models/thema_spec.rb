require 'spec_helper'

describe Thema do
  
  [:text, :title].each do |attr|
    it "should not be valid without #{attr}" do
      tg=FactoryGirl.build(:themengruppe)
      t = FactoryGirl.build(:thema, attr=>nil)
      t.themengruppe=tg
      t.should_not be_valid
    end
  end
    it "should not be valid without Themengruppe" do
      tg=FactoryGirl.build(:themengruppe)
      t = FactoryGirl.build(:thema)
       t.should_not be_valid
    end
  


end
