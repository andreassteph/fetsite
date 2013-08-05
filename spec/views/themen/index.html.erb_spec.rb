require 'spec_helper'

describe "themen/index" do
  before(:each) do
    assign(:themen, [
      stub_model(Thema,
        :title => "Title",
        :text => "MyText"
      ),
      stub_model(Thema,
        :title => "Title",
        :text => "MyText"
      )
    ])
  end

  it "renders a list of themen" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
  end
end
