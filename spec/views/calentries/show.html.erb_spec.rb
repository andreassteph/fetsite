require 'spec_helper'

describe "calentries/show" do
  before(:each) do
    @calentry = assign(:calentry, stub_model(Calentry,
      :summary => "Summary",
      :typ => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Summary/)
    rendered.should match(/1/)
  end
end
