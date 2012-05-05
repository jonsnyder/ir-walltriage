class AddEmptyStopwordList < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      stopword_list = StopwordList.create( :name => "No Stopwords")
    end
  end

  def down
    ActiveRecord::Base.transaction do
      StopwordList.where( :name => "No Stopwords").destroy_all
    end
  end
end
