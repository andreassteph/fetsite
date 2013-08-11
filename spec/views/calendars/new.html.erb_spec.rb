require 'spec_helper'

describe "calendars/new" do
  before(:each) do
    assign(:calendar, stub_model(Calendar,
      :name => "MyString",
      :public => false
    ).as_new_record)
  end

  it "renders new calendar form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calendars_path, "post" do
      assert_select "input#calendar_name[name=?]", "calendar[name]"
      assert_select "input#calendar_public[name=?]", "calendar[public]"
    end
  end
end
