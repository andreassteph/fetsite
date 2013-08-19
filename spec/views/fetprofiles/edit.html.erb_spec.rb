require 'spec_helper'

describe "fetprofiles/edit" do
  before(:each) do
    @fetprofile = assign(:fetprofile, stub_model(Fetprofile,
      :vorname => "MyString",
      :nachname => "MyString",
      :short => "MyString",
      :fetmailalias => "MyString",
      :desc => "MyText",
      :picture => "MyString",
      :active => false
    ))
  end

  it "renders the edit fetprofile form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetprofile_path(@fetprofile), "post" do
      assert_select "input#fetprofile_vorname[name=?]", "fetprofile[vorname]"
      assert_select "input#fetprofile_nachname[name=?]", "fetprofile[nachname]"
      assert_select "input#fetprofile_short[name=?]", "fetprofile[short]"
      assert_select "input#fetprofile_fetmailalias[name=?]", "fetprofile[fetmailalias]"
      assert_select "textarea#fetprofile_desc[name=?]", "fetprofile[desc]"
      assert_select "input#fetprofile_picture[name=?]", "fetprofile[picture]"
      assert_select "input#fetprofile_active[name=?]", "fetprofile[active]"
    end
  end
end
