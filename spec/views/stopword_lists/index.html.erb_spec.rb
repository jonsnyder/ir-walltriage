require 'spec_helper'

describe "stopword_lists/index" do
  before(:each) do
    assign(:stopword_lists, [
      stub_model(StopwordList,
        :name => "Name"
      ),
      stub_model(StopwordList,
        :name => "Name"
      )
    ])
  end

  it "renders a list of stopword_lists" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
