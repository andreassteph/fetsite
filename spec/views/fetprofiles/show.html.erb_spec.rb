require 'spec_helper'

describe "fetprofiles/show" do
  before(:each) do
    @fetprofile = assign(:fetprofile, stub_model(Fetprofile,
      :vorname => "Vorname",
      :nachname => "Nachname",
      :short => "Short",
      :fetmailalias => "Fetmailalias",
      :desc => "MyText",
      :picture => "Picture",
      :active => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Vorname/)
    rendered.should match(/Nachname/)
    rendered.should match(/Short/)
    rendered.should match(/Fetmailalias/)
    rendered.should match(/MyText/)
    rendered.should match(/Picture/)
    rendered.should match(/false/)
  end
end
