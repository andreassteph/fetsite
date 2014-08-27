require 'spec_helper'

describe "fetmeetings/show" do
  before(:each) do
    @fetmeeting = assign(:fetmeeting, stub_model(Fetmeeting,
      :tnlist => "MyText",
      :typ => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/MyText/)
    rendered.should match(/1/)
  end
end
