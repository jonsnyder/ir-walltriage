class MalletRun < ActiveRecord::Base
  belongs_to :dataset
  belongs_to :stopword_list
  has_many :mallet_commands
  has_many :lda_topics

  def jobs
    mallet_commands.select('distinct job').map(&:job)
  end
  
  TOKEN_REGEX = '[^\s]+'
  MALLET = './vendor/mallet/bin/mallet'
  
  def run
    self.state = "Running"
    save!
    
    job = "Default"
    mallet_commands.job(job).destroy_all
    
    dir = "./tmp/mallet_run_#{id}"
    input_file = dir + "/input.txt"
    mallet_file = dir + "/input.mallet"
    output_doc_topics = dir + "/output_doc_topics.txt"
    xml_topic_phrase_report = dir + "/xml_topic_phrase_report.xml"
    
    make_directory( dir, job)
    
    dataset.to_mallet_file( input_file) { |word| !stopword_list.contains( word) }
    
    mallet_commands.create( :job => job, :command => "#{MALLET} import-file --keep-sequence --input #{input_file} --output #{mallet_file} --token-regex '#{TOKEN_REGEX}'").run
    mallet_commands.create( :job => job, :command => "#{MALLET} train-topics --input #{mallet_file} #{mallet_options} --output-doc-topics #{output_doc_topics} --xml-topic-phrase-report #{xml_topic_phrase_report} --output-state #{dir}/output_state.gz").run


    lda_topics.destroy_all
    # parse the output files here
    topics = import_xml_topic_phrase_report( xml_topic_phrase_report)
    import_doc_topics( output_doc_topics, topics)

    self.state = "Finished"
    save!
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

      topics.each_with_index  do |topic,i|
        topic.lda_post_topics.create( :post_id => id, :weight => weights[i])
      end
    end
  end

  def k_fold_cross_validation( k)
    mallet_commands.jobs_like( "Evaluation").destroy_all

    dataset.k_fold_cross_validation_sets( k) do |i, training_set, validation_set|
      self.state = "Running Evaluation #{i+1} of #{k}"
      save!
      run_evaluation( i, training_set, validation_set)
    end
    
  end
  
  def run_evaluation( i, training_set, validation_set)
    job = "Evaluation #{i+1}"
    dir = "./tmp/mallet_run_#{id}/evaluation_#{i+1}"
    
    make_directory( dir, job)

    training_input_file = dir + "/training_input.txt"
    training_mallet_file = dir + "/training_input.mallet"
    validation_input_file = dir + "/validation_input.txt"
    validation_mallet_file = dir + "/validation_input.mallet"
    evaluator_file = dir + "/evaluator"
    
    dataset.to_mallet_file( training_input_file, training_set) { |word| !stopword_list.contains(word) }
    dataset.to_mallet_file( validation_input_file, validation_set) { |word| !stopword_list.contains(word) }
    
    mallet_commands.create( :job => job, :command => "#{MALLET} import-file --keep-sequence --input #{training_input_file} --output #{training_mallet_file} --token-regex '#{TOKEN_REGEX}'").run
    mallet_commands.create( :job => job, :command => "#{MALLET} train-topics --input #{training_mallet_file} #{mallet_options} --evaluator-filename #{evaluator_file}").run

    mallet_commands.create( :job => job, :command => "#{MALLET} import-file --keep-sequence --use-pipe-from #{training_mallet_file} --input #{validation_input_file} --output #{validation_mallet_file} --token-regex '#{TOKEN_REGEX}'").run
    mallet_commands.create( :job => job, :command => "#{MALLET} evaluate-topics --evaluator #{evaluator_file} --input #{validation_mallet_file} --output-doc-probs #{dir}/output_doc_probs.txt --output-prob #{dir}/output_prob.txt").run
  end

  def mallet_options
    "--num-topics #{num_topics} --num-iterations #{num_iterations} --optimize-burn-in #{optimize_burn_in} --alpha #{alpha} --use-symmetric-alpha #{use_symetric_burn_in ? 'TRUE' : 'FALSE'} --show-topics-interval 500"
  end

  def make_directory( dir, job) 
    mallet_commands.create( :job => job, :command => "[ -e #{dir} ] && rm -rf #{dir}; mkdir #{dir}" ).run
  end
end
