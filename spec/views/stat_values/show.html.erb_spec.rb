require 'spec_helper'

describe "stat_values/show" do
  before(:each) do
    @stat_value = assign(:stat_value, stub_model(StatValue,
      :stat => nil,
      :strategy => nil,
      :access_token => nil,
      :value => 1.5
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/1.5/)
  end
end
