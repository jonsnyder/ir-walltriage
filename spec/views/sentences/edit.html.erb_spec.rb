require 'spec_helper'

describe "sentences/edit" do
  before(:each) do
    @sentence = assign(:sentence, stub_model(Sentence,
      :raw => "MyString",
      :tokenized => "MyString",
      :post => nil,
      :comment => nil,
      :stopword_list => nil
    ))
  end

  it "renders the edit sentence form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => sentences_path(@sentence), :method => "post" do
      assert_select "input#sentence_raw", :name => "sentence[raw]"
      assert_select "input#sentence_tokenized", :name => "sentence[tokenized]"
      assert_select "input#sentence_post", :name => "sentence[post]"
      assert_select "input#sentence_comment", :name => "sentence[comment]"
      assert_select "input#sentence_stopword_list", :name => "sentence[stopword_list]"
    end
  end
end
