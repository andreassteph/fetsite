require 'spec_helper'

describe "fotos/show" do
  before(:each) do
    @foto = assign(:foto, stub_model(Foto,
      :title => "Title",
      :desc => "MyText",
      :gallery_id => 1,
      :datei => "Datei"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Title/)
    rendered.should match(/MyText/)
    rendered.should match(/1/)
    rendered.should match(/Datei/)
  end
end
