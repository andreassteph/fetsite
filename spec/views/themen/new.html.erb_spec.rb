require 'spec_helper'

describe "themen/new" do
  before(:each) do
    assign(:thema, stub_model(Thema,
      :title => "MyString",
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new thema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", themen_path, "post" do
      assert_select "input#thema_title[name=?]", "thema[title]"
      assert_select "textarea#thema_text[name=?]", "thema[text]"
    end
  end
end
