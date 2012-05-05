require 'spec_helper'

describe "stopwords/show" do
  before(:each) do
    @stopword = assign(:stopword, stub_model(Stopword,
      :word => "Word",
      :stopword_list => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Word/)
    rendered.should match(//)
  end
end
