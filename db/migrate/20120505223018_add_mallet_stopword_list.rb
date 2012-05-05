class AddMalletStopwordList < ActiveRecord::Migration
  def up
    ActiveRecord::Base.transaction do
      stopword_list = StopwordList.create( :name => "Mallet List")
      
      file = open( "./vendor/mallet/stoplists/en.txt", "r")
      file.each_line do |line|
        word = line.strip
        if !word.blank?
          stopword_list.stopwords.create( :word => word)
        end
      end
    end
  end

  def down
    ActiveRecord::Base.transaction do
      StopwordList.where( :name => "Mallet List").destroy_all
    end
  end
end
