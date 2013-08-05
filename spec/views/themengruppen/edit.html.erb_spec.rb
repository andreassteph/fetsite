require 'spec_helper'

describe "themengruppen/edit" do
  before(:each) do
    @themengruppe = assign(:themengruppe, stub_model(Themengruppe,
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit themengruppe form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", themengruppe_path(@themengruppe), "post" do
      assert_select "input#themengruppe_title[name=?]", "themengruppe[title]"
      assert_select "textarea#themengruppe_text[name=?]", "themengruppe[text]"
    end
  end
end
