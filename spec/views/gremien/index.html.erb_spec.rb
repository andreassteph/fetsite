require 'spec_helper'

describe "gremien/index" do
  before(:each) do
    assign(:gremien, [
      stub_model(Gremium,
        :name => "Name",
        :desc => "MyText",
        :typ => "Typ"
      ),
      stub_model(Gremium,
        :name => "Name",
        :desc => "MyText",
        :typ => "Typ"
      )
    ])
  end

  it "renders a list of gremien" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Typ".to_s, :count => 2
  end
end
