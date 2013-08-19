require 'spec_helper'

describe "gremien/show" do
  before(:each) do
    @gremium = assign(:gremium, stub_model(Gremium,
      :name => "Name",
      :desc => "MyText",
      :typ => "Typ"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Typ/)
  end
end
