require 'spec_helper'

describe "fetzneditions/show" do
  before(:each) do
    @fetznedition = assign(:fetznedition, stub_model(Fetznedition,
      :title => "Title",
      :desc => "MyText",
      :datei => "Datei"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/Datei/)
  end
end
