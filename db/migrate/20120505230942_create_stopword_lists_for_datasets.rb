class CreateStopwordListsForDatasets < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do

      add_column :stopwords, :doc_freq, :integer
      
      Dataset.all.each do |dataset|
        df = dataset.df

        list = StopwordList.new( :name => "Top 50 words", :dataset => dataset)
        list.add_words( df.top_n_words 50)
        list.save

        #list = StopwordList.new( :name => "Top 50 words, no words once", :dataset => dataset)
        #list.add_words( df.top_n_words( 50))
        #list.add_words( df.words_occuring_once)
        #list.save
        
        list = StopwordList.new( :name => "Top 200 words", :dataset => dataset)
        list.add_words( df.top_n_words 200)
        list.save

        #list = StopwordList.new( :name => "Top 200 words, no words once", :dataset => dataset)
        #list.add_words( df.top_n_words( 200))
        #list.add_words( df.words_occuring_once)
        #list.save

        list = StopwordList.new( :name => "Words in more than 50% of documents", :dataset => dataset)
        list.add_words( df.words_occuring_more_than_n_times( dataset.posts.count / 2))
        #list.add_words( df.words_occuring_once)
        list.save
        
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do

      
      Dataset.all.each do |dataset|
        dataset.stopword_lists.destroy_all
      end

      remove_column :stopwords, :doc_freq
    end
  end
end
