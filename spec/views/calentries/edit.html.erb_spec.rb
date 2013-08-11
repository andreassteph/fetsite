require 'spec_helper'

describe "calentries/edit" do
  before(:each) do
    @calentry = assign(:calentry, stub_model(Calentry,
      :summary => "MyString",
      :typ => 1
    ))
  end

  it "renders the edit calentry form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", calentry_path(@calentry), "post" do
      assert_select "input#calentry_summary[name=?]", "calentry[summary]"
      assert_select "input#calentry_typ[name=?]", "calentry[typ]"
    end
  end
end
