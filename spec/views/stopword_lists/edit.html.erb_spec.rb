require 'spec_helper'

describe "stopword_lists/edit" do
  before(:each) do
    @stopword_list = assign(:stopword_list, stub_model(StopwordList,
      :name => "MyString"
    ))
  end

  it "renders the edit stopword_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stopword_lists_path(@stopword_list), :method => "post" do
      assert_select "input#stopword_list_name", :name => "stopword_list[name]"
    end
  end
end
