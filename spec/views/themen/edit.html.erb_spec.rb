require 'spec_helper'

describe "themen/edit" do
  before(:each) do
    @thema = assign(:thema, stub_model(Thema,
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit thema form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", thema_path(@thema), "post" do
      assert_select "input#thema_title[name=?]", "thema[title]"
      assert_select "textarea#thema_text[name=?]", "thema[text]"
    end
  end
end
