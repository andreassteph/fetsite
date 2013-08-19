require 'spec_helper'

describe "Fetprofiles" do
  describe "GET /fetprofiles" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get fetprofiles_path
      response.status.should be(200)
    end
  end
end
