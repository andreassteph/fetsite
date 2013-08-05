require 'spec_helper'

describe "calentries/new" do
  before(:each) do
    assign(:calentry, stub_model(Calentry,
      :summary => "MyString",
      :typ => 1
    ).as_new_record)
  end

  it "renders new calentry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calentries_path, "post" do
      assert_select "input#calentry_summary[name=?]", "calentry[summary]"
      assert_select "input#calentry_typ[name=?]", "calentry[typ]"
    end
  end
end
