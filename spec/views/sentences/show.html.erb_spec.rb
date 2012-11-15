require 'spec_helper'

describe "sentences/show" do
  before(:each) do
    @sentence = assign(:sentence, stub_model(Sentence,
      :raw => "Raw",
      :tokenized => "Tokenized",
      :post => nil,
      :comment => nil,
      :stopword_list => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Raw/)
    rendered.should match(/Tokenized/)
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(//)
  end
end
