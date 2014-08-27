require 'spec_helper'

describe "fetmeetingtops/show" do
  before(:each) do
    @fetmeetingtop = assign(:fetmeetingtop, stub_model(Fetmeetingtop,
      :title => "Title",
      :text => "MyText",
      :discussion => "MyText",
      :ersteller => "Ersteller",
      :fetmeeting_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/MyText/)
    rendered.should match(/Ersteller/)
    rendered.should match(/1/)
  end
end
