require 'spec_helper'

describe "fotos/new" do
  before(:each) do
    assign(:foto, stub_model(Foto,
      :title => "MyString",
      :desc => "MyText",
      :gallery_id => 1,
      :datei => "MyString"
    ).as_new_record)
  end

  it "renders new foto form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", fotos_path, "post" do
      assert_select "input#foto_title[name=?]", "foto[title]"
      assert_select "textarea#foto_desc[name=?]", "foto[desc]"
      assert_select "input#foto_gallery_id[name=?]", "foto[gallery_id]"
      assert_select "input#foto_datei[name=?]", "foto[datei]"
    end
  end
end
