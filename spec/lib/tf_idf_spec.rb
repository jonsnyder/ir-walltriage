require 'spec_helper'

describe TfIdf do
  it "computes idf correctly" do
    doc_freq = WordFrequency.new
    doc_freq.add('a')
    doc_freq.add('a')
    doc_freq.add('b')
    doc_freq.add('c')

    tfidf = TfIdf.new( doc_freq, 2)
    tfidf.add('a')
    tfidf.add('b')
    tfidf.add('b')
    
    tfidf.tf_idf( 'b').should eq (2 * Math.log( 2))
    tfidf.tf_idf( 'a').should eq 0
    tfidf.tf_idf( 'c').should eq 0

    tfidf.squared.should eq (2 * Math.log(2))**2
  end
end
