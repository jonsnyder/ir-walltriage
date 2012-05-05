require 'spec_helper'

describe "stopwords/index" do
  before(:each) do
    assign(:stopwords, [
      stub_model(Stopword,
        :word => "Word",
        :stopword_list => nil
      ),
      stub_model(Stopword,
        :word => "Word",
        :stopword_list => nil
      )
    ])
  end

  it "renders a list of stopwords" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Word".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
