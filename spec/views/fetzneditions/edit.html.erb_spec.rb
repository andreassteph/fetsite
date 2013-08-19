require 'spec_helper'

describe "fetzneditions/edit" do
  before(:each) do
    @fetznedition = assign(:fetznedition, stub_model(Fetznedition,
      :title => "MyString",
      :desc => "MyText",
      :datei => "MyString"
    ))
  end

  it "renders the edit fetznedition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetznedition_path(@fetznedition), "post" do
      assert_select "input#fetznedition_title[name=?]", "fetznedition[title]"
      assert_select "textarea#fetznedition_desc[name=?]", "fetznedition[desc]"
      assert_select "input#fetznedition_datei[name=?]", "fetznedition[datei]"
    end
  end
end
