require 'spec_helper'

describe "fetprofiles/index" do
  before(:each) do
    assign(:fetprofiles, [
      stub_model(Fetprofile,
        :vorname => "Vorname",
        :nachname => "Nachname",
        :short => "Short",
        :fetmailalias => "Fetmailalias",
        :desc => "MyText",
        :picture => "Picture",
        :active => false
      ),
      stub_model(Fetprofile,
        :vorname => "Vorname",
        :nachname => "Nachname",
        :short => "Short",
        :fetmailalias => "Fetmailalias",
        :desc => "MyText",
        :picture => "Picture",
        :active => false
      )
    ])
  end

  it "renders a list of fetprofiles" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Vorname".to_s, :count => 2
    assert_select "tr>td", :text => "Nachname".to_s, :count => 2
    assert_select "tr>td", :text => "Short".to_s, :count => 2
    assert_select "tr>td", :text => "Fetmailalias".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Picture".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
