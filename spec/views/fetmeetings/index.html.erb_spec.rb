require 'spec_helper'

describe "fetmeetings/index" do
  before(:each) do
    assign(:fetmeetings, [
      stub_model(Fetmeeting,
        :tnlist => "MyText",
        :typ => 1
      ),
      stub_model(Fetmeeting,
        :tnlist => "MyText",
        :typ => 1
      )
    ])
  end

  it "renders a list of fetmeetings" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
