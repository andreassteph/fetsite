require 'spec_helper'

describe "memberships/edit" do
  before(:each) do
    @membership = assign(:membership, stub_model(Membership,
      :fetprofile_id => "MyString",
      :gremium_id => "MyString",
      :typ => "MyString"
    ))
  end

  it "renders the edit membership form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", membership_path(@membership), "post" do
      assert_select "input#membership_fetprofile_id[name=?]", "membership[fetprofile_id]"
      assert_select "input#membership_gremium_id[name=?]", "membership[gremium_id]"
      assert_select "input#membership_typ[name=?]", "membership[typ]"
    end
  end
end
