require 'spec_helper'

describe "fetmeetingtops/new" do
  before(:each) do
    assign(:fetmeetingtop, stub_model(Fetmeetingtop,
      :title => "MyString",
      :text => "MyText",
      :discussion => "MyText",
      :ersteller => "MyString",
      :fetmeeting_id => 1
    ).as_new_record)
  end

  it "renders new fetmeetingtop form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fetmeetingtops_path, "post" do
      assert_select "input#fetmeetingtop_title[name=?]", "fetmeetingtop[title]"
      assert_select "textarea#fetmeetingtop_text[name=?]", "fetmeetingtop[text]"
      assert_select "textarea#fetmeetingtop_discussion[name=?]", "fetmeetingtop[discussion]"
      assert_select "input#fetmeetingtop_ersteller[name=?]", "fetmeetingtop[ersteller]"
      assert_select "input#fetmeetingtop_fetmeeting_id[name=?]", "fetmeetingtop[fetmeeting_id]"
    end
  end
end
