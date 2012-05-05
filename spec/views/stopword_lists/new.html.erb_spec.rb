require 'spec_helper'

describe "stopword_lists/new" do
  before(:each) do
    assign(:stopword_list, stub_model(StopwordList,
      :name => "MyString"
    ).as_new_record)
  end

  it "renders new stopword_list form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stopword_lists_path, :method => "post" do
      assert_select "input#stopword_list_name", :name => "stopword_list[name]"
    end
  end
end
