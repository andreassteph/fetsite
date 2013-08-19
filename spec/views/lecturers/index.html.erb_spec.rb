require 'spec_helper'

describe "lecturers/index" do
  before(:each) do
    assign(:lecturers, [
      stub_model(Lecturer,
        :name => "Name",
        :email => "Email",
        :oid => 1,
        :picture => "Picture"
      ),
      stub_model(Lecturer,
        :name => "Name",
        :email => "Email",
        :oid => 1,
        :picture => "Picture"
      )
    ])
  end

  it "renders a list of lecturers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "Email".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => "Picture".to_s, :count => 2
  end
end
