require 'spec_helper'

describe "fetmeetingtops/edit" do
  before(:each) do
    @fetmeetingtop = assign(:fetmeetingtop, stub_model(Fetmeetingtop,
      :title => "MyString",
      :text => "MyText",
      :discussion => "MyText",
      :ersteller => "MyString",
      :fetmeeting_id => 1
    ))
  end

  it "renders the edit fetmeetingtop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetmeetingtop_path(@fetmeetingtop), "post" do
      assert_select "input#fetmeetingtop_title[name=?]", "fetmeetingtop[title]"
      assert_select "textarea#fetmeetingtop_text[name=?]", "fetmeetingtop[text]"
      assert_select "textarea#fetmeetingtop_discussion[name=?]", "fetmeetingtop[discussion]"
      assert_select "input#fetmeetingtop_ersteller[name=?]", "fetmeetingtop[ersteller]"
      assert_select "input#fetmeetingtop_fetmeeting_id[name=?]", "fetmeetingtop[fetmeeting_id]"
    end
  end
end
