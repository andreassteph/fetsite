require 'spec_helper'

describe "calentries/index" do
  before(:each) do
    assign(:calentries, [
      stub_model(Calentry,
        :summary => "Summary",
        :typ => 1
      ),
      stub_model(Calentry,
        :summary => "Summary",
        :typ => 1
      )
    ])
  end

  it "renders a list of calentries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Summary".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
