require 'spec_helper'

describe "sentences/index" do
  before(:each) do
    assign(:sentences, [
      stub_model(Sentence,
        :raw => "Raw",
        :tokenized => "Tokenized",
        :post => nil,
        :comment => nil,
        :stopword_list => nil
      ),
      stub_model(Sentence,
        :raw => "Raw",
        :tokenized => "Tokenized",
        :post => nil,
        :comment => nil,
        :stopword_list => nil
      )
    ])
  end

  it "renders a list of sentences" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Raw".to_s, :count => 2
    assert_select "tr>td", :text => "Tokenized".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
