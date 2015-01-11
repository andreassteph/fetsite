require 'spec_helper'

describe "fetmeetingtops/index" do
  before(:each) do
    assign(:fetmeetingtops, [
      stub_model(Fetmeetingtop,
        :title => "Title",
        :text => "MyText",
        :discussion => "MyText",
        :ersteller => "Ersteller",
        :fetmeeting_id => 1
      ),
      stub_model(Fetmeetingtop,
        :title => "Title",
        :text => "MyText",
        :discussion => "MyText",
        :ersteller => "Ersteller",
        :fetmeeting_id => 1
      )
    ])
  end

  it "renders a list of fetmeetingtops" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Ersteller".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
