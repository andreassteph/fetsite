require 'spec_helper'

describe "themen/show" do
  before(:each) do
    @thema = assign(:thema, stub_model(Thema,
      :title => "Title",
      :text => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
  end
end
