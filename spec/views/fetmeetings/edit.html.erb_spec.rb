require 'spec_helper'

describe "fetmeetings/edit" do
  before(:each) do
    @fetmeeting = assign(:fetmeeting, stub_model(Fetmeeting,
      :tnlist => "MyText",
      :typ => 1
    ))
  end

  it "renders the edit fetmeeting form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetmeeting_path(@fetmeeting), "post" do
      assert_select "textarea#fetmeeting_tnlist[name=?]", "fetmeeting[tnlist]"
      assert_select "input#fetmeeting_typ[name=?]", "fetmeeting[typ]"
    end
  end
end
