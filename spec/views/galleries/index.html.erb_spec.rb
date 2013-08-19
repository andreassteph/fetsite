require 'spec_helper'

describe "galleries/index" do
  before(:each) do
    assign(:galleries, [
      stub_model(Gallery,
        :name => "Name",
        :desc => "MyText"
      ),
      stub_model(Gallery,
        :name => "Name",
        :desc => "MyText"
      )
    ])
  end

  it "renders a list of galleries" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
