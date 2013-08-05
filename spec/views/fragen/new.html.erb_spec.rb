require 'spec_helper'

describe "fragen/new" do
  before(:each) do
    assign(:frage, stub_model(Frage,
      :title => "MyString",
      :text => "MyText"
    ).as_new_record)
  end

  it "renders new frage form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fragen_path, "post" do
      assert_select "input#frage_title[name=?]", "frage[title]"
      assert_select "textarea#frage_text[name=?]", "frage[text]"
    end
  end
end
