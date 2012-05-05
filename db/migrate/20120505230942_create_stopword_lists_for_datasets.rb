class CreateStopwordListsForDatasets < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do 
      Dataset.all.each do |dataset|
        df = dataset.df
        
        list = StopwordList.new( :name => "Top 200 words", :dataset => dataset)
        list.add_words( df.top_n_words 200)
        list.save

        list = StopwordList.new( :name => "Top 200 words, no words once", :dataset => dataset)
        list.add_words( df.top_n_words( 200))
        list.add_words( df.words_occuring_once)
        list.save

        list = StopwordList.new( :name => "Words in more than 50% of documents, no words once", :dataset => dataset)
        list.add_words( df.words_occuring_more_than_n_times( dataset.posts.count ))
        list.add_words( df.words_occuring_once)
        list.save
        
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      Dataset.all.each do |dataset|
        dataset.stopword_lists.destroy_all
      end
    end
  end
end
