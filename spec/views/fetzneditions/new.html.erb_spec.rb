require 'spec_helper'

describe "fetzneditions/new" do
  before(:each) do
    assign(:fetznedition, stub_model(Fetznedition,
      :title => "MyString",
      :desc => "MyText",
      :datei => "MyString"
    ).as_new_record)
  end

  it "renders new fetznedition form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetzneditions_path, "post" do
      assert_select "input#fetznedition_title[name=?]", "fetznedition[title]"
      assert_select "textarea#fetznedition_desc[name=?]", "fetznedition[desc]"
      assert_select "input#fetznedition_datei[name=?]", "fetznedition[datei]"
    end
  end
end
