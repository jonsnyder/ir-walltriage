require 'spec_helper'

describe "stopwords/new" do
  before(:each) do
    assign(:stopword, stub_model(Stopword,
      :word => "MyString",
      :stopword_list => nil
    ).as_new_record)
  end

  it "renders new stopword form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => stopwords_path, :method => "post" do
      assert_select "input#stopword_word", :name => "stopword[word]"
      assert_select "input#stopword_stopword_list", :name => "stopword[stopword_list]"
    end
  end
end
