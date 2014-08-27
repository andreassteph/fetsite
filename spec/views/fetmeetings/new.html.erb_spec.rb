require 'spec_helper'

describe "fetmeetings/new" do
  before(:each) do
    assign(:fetmeeting, stub_model(Fetmeeting,
      :tnlist => "MyText",
      :typ => 1
    ).as_new_record)
  end

  it "renders new fetmeeting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetmeetings_path, "post" do
      assert_select "textarea#fetmeeting_tnlist[name=?]", "fetmeeting[tnlist]"
      assert_select "input#fetmeeting_typ[name=?]", "fetmeeting[typ]"
    end
  end
end
