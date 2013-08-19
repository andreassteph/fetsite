require 'spec_helper'

describe "gremien/new" do
  before(:each) do
    assign(:gremium, stub_model(Gremium,
      :name => "MyString",
      :desc => "MyText",
      :typ => "MyString"
    ).as_new_record)
  end

  it "renders new gremium form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", gremien_path, "post" do
      assert_select "input#gremium_name[name=?]", "gremium[name]"
      assert_select "textarea#gremium_desc[name=?]", "gremium[desc]"
      assert_select "input#gremium_typ[name=?]", "gremium[typ]"
    end
  end
end
