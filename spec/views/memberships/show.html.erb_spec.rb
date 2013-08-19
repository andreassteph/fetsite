require 'spec_helper'

describe "memberships/show" do
  before(:each) do
    @membership = assign(:membership, stub_model(Membership,
      :fetprofile_id => "Fetprofile",
      :gremium_id => "Gremium",
      :typ => "Typ"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Fetprofile/)
    rendered.should match(/Gremium/)
    rendered.should match(/Typ/)
  end
end
