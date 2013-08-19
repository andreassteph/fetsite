require 'spec_helper'

describe "fetzneditions/index" do
  before(:each) do
    assign(:fetzneditions, [
      stub_model(Fetznedition,
        :title => "Title",
        :desc => "MyText",
        :datei => "Datei"
      ),
      stub_model(Fetznedition,
        :title => "Title",
        :desc => "MyText",
        :datei => "Datei"
      )
    ])
  end

  it "renders a list of fetzneditions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Datei".to_s, :count => 2
  end
end
