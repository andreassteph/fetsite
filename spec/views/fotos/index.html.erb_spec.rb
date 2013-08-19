require 'spec_helper'

describe "fotos/index" do
  before(:each) do
    assign(:fotos, [
      stub_model(Foto,
        :title => "Title",
        :desc => "MyText",
        :gallery_id => 1,
        :datei => "Datei"
      ),
      stub_model(Foto,
        :title => "Title",
        :desc => "MyText",
        :gallery_id => 1,
        :datei => "Datei"
      )
    ])
  end

  it "renders a list of fotos" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Datei".to_s, :count => 2
  end
end
