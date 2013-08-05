require 'spec_helper'

describe "themengruppen/new" do
  before(:each) do
    assign(:themengruppe, stub_model(Themengruppe,
      :title => "MyString",
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new themengruppe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", themengruppen_path, "post" do
      assert_select "input#themengruppe_title[name=?]", "themengruppe[title]"
      assert_select "textarea#themengruppe_text[name=?]", "themengruppe[text]"
    end
  end
end
