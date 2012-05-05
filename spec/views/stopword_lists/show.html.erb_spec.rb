require 'spec_helper'

describe "stopword_lists/show" do
  before(:each) do
    @stopword_list = assign(:stopword_list, stub_model(StopwordList,
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
  end
end
