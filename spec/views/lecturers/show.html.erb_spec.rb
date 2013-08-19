require 'spec_helper'

describe "lecturers/show" do
  before(:each) do
    @lecturer = assign(:lecturer, stub_model(Lecturer,
      :name => "Name",
      :email => "Email",
      :oid => 1,
      :picture => "Picture"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/Email/)
    rendered.should match(/1/)
    rendered.should match(/Picture/)
  end
end
