require 'spec_helper'

describe "stat_values/new" do
  before(:each) do
    assign(:stat_value, stub_model(StatValue,
      :stat => nil,
      :strategy => nil,
      :access_token => nil,
      :value => 1.5
    ).as_new_record)
  end

  it "renders new stat_value form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stat_values_path, :method => "post" do
      assert_select "input#stat_value_stat", :name => "stat_value[stat]"
      assert_select "input#stat_value_strategy", :name => "stat_value[strategy]"
      assert_select "input#stat_value_access_token", :name => "stat_value[access_token]"
      assert_select "input#stat_value_value", :name => "stat_value[value]"
    end
  end
end
