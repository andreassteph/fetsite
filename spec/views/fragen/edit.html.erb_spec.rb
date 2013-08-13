require 'spec_helper'

describe "fragen/edit" do
  before(:each) do
    @frage = assign(:frage, stub_model(Frage,
      :title => "MyString",
      :text => "MyText"
    ))
  end

  it "renders the edit frage form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", frage_path(@frage), "post" do
      assert_select "input#frage_title[name=?]", "frage[title]"
      assert_select "textarea#frage_text[name=?]", "frage[text]"
    end
  end
end
