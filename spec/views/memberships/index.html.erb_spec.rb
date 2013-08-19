require 'spec_helper'

describe "memberships/index" do
  before(:each) do
    assign(:memberships, [
      stub_model(Membership,
        :fetprofile_id => "Fetprofile",
        :gremium_id => "Gremium",
        :typ => "Typ"
      ),
      stub_model(Membership,
        :fetprofile_id => "Fetprofile",
        :gremium_id => "Gremium",
        :typ => "Typ"
      )
    ])
  end

  it "renders a list of memberships" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Fetprofile".to_s, :count => 2
    assert_select "tr>td", :text => "Gremium".to_s, :count => 2
    assert_select "tr>td", :text => "Typ".to_s, :count => 2
  end
end
