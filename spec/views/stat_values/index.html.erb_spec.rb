require 'spec_helper'

describe "stat_values/index" do
  before(:each) do
    assign(:stat_values, [
      stub_model(StatValue,
        :stat => nil,
        :strategy => nil,
        :access_token => nil,
        :value => 1.5
      ),
      stub_model(StatValue,
        :stat => nil,
        :strategy => nil,
        :access_token => nil,
        :value => 1.5
      )
    ])
  end

  it "renders a list of stat_values" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => 1.5.to_s, :count => 2
  end
end
