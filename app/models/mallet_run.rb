class MalletRun < ActiveRecord::Base
  belongs_to :dataset
  has_many :mallet_commands
  has_many :lda_topics

  def run
    mallet_commands.destroy_all
    
    dir = "./tmp/mallet_run_#{id}"
    input_file = dir + "/input.txt"
    mallet_file = dir + "/input.mallet"
    token_regex = '[^\s]+'
    output_doc_topics = dir + "/output_doc_topics.txt"
    xml_topic_phrase_report = dir + "/xml_topic_phrase_report.xml"

    
    mallet_commands.create( :command => "rm -rf #{dir}; mkdir #{dir}").run
    
    dataset.to_mallet_file( input_file)
    
    mallet_commands.create( :command => "./vendor/mallet/bin/mallet import-file --keep-sequence --input #{input_file} --output #{mallet_file} --token-regex '#{token_regex}' --remove-stopwords TRUE").run
    mallet_commands.create( :command => "./vendor/mallet/bin/mallet train-topics --input #{mallet_file} --num-topics #{num_topics} --num-iterations #{num_iterations} --optimize-burn-in #{optimize_burn_in} --use-symmetric-alpha #{use_symetric_burn_in ? 'TRUE' : 'FALSE'} --show-topics-interval 500 --output-doc-topics #{output_doc_topics} --xml-topic-phrase-report #{xml_topic_phrase_report}").run


    lda_topics.destroy_all
    # parse the output files here
    topics = import_xml_topic_phrase_report( xml_topic_phrase_report)
    puts topics.inspect
    import_doc_topics( output_doc_topics, topics)
  end


  def import_xml_topic_phrase_report( filename)
    file = open( filename, 'r')
    doc = Nokogiri::XML( file)
    topics = []
    doc.xpath('//topics/topic').each do |topic|
      t = lda_topics.create( :alpha => topic['alpha'], :tokens => topic['totalTokens'], :title => topic['titles'])
      topic.children.each do |topic_word|
        if !topic_word.text?
          t.lda_topic_words.create( :weight => topic_word['weight'], :tokens => topic_word['count'], :word => topic_word.content)
        end
      end
      topics << t
    end
    topics
  end

  def import_doc_topics( filename, topics)
    file = open( filename, 'r')
    file.each_line do |line|
      if line =~ /^#/
        next
      end
      i, id, *doc_topics = line.split("\t")
      doc_topics.pop
      weights = Hash[*doc_topics].sort_by { |k,v| k}.map(&:last)
      puts "WEIGHTS - #{weights.inspect}"

      topics.each_with_index  do |topic,i|
        topic.lda_post_topics.create( :post_id => id, :weight => weights[i])
      end
    end
  end
end
