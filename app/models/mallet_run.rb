require 'zlib'

class MalletRun < ActiveRecord::Base
  include IterMethods

  belongs_to :dataset
  belongs_to :stopword_list
  has_many :mallet_commands
  has_many :lda_topics
  has_many :strategies

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
    columns = [:lda_topic_id, :weight, :tokens, :word]
    rows = []
    doc.xpath('//topics/topic').each do |topic|
      t = lda_topics.create( :alpha => topic['alpha'], :tokens => topic['totalTokens'], :title => topic['titles'])
      topic.children.each do |topic_word|
        if !topic_word.text?
          rows << [t.id, topic_word['weight'], topic_word['count'], topic_word.content.strip[0..200] ]
        end
      end
      topics << t
    end
    LdaTopicWord.import columns, rows, :validate => false
    topics
  end

  def import_doc_topics( filename, topics)
    file = open( filename, 'r')
    columns = [:lda_topic_id, :post_id, :weight]
    rows = []
    file.each_line do |line|
      if line =~ /^#/
        next
      end
      i, id, *doc_topics = line.split("\t")
      doc_topics.pop

      doc_topics.take(10).each_slice(2) do |topic_i,weight|
        topic_id = topics[topic_i.to_i].id
        if topic_id && id.to_i && weight.to_f
          rows << [topics[topic_i.to_i].id, id.to_i, weight.to_f]
        else
          puts "null =================="
          puts topic_id.inspect
          puts id.inpsect
          puts weight.inspect
        end
      end
      if rows.size > 1000
        #puts rows
        LdaPostTopic.import columns, rows, :validate => false
        rows = []
      end
    end
    if rows.size > 0
      LdaPostTopic.import columns, rows, :validate => false
    end
  end

  def k_fold_cross_validation( k)
    mallet_commands.jobs_like( "Evaluation").destroy_all

    total_score = 0.0
    total_words = 0
    
    dataset.k_fold_cross_validation_sets( k) do |i, training_set, validation_set|
      self.state = "Running Evaluation #{i+1} of #{k}"
      save!
      score, words = run_evaluation( i, training_set, validation_set)
      total_score += score
      total_words += words
    end

    self.validation_score = total_score / total_words
    self.state = "Finished Cross Validation"
    self.save!
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
    output_prob_file = dir + "/output_prob.txt"
    
    dataset.to_mallet_file( training_input_file, training_set) { |word| !stopword_list.contains(word) }
    validation_word_count = 0
    dataset.to_mallet_file( validation_input_file, validation_set) do |word|
      if stopword_list.contains(word)
        false
      else
        validation_word_count += 1
        true
      end
    end
    
    mallet_commands.create( :job => job, :command => "#{MALLET} import-file --keep-sequence --input #{training_input_file} --output #{training_mallet_file} --token-regex '#{TOKEN_REGEX}'").run
    mallet_commands.create( :job => job, :command => "#{MALLET} train-topics --input #{training_mallet_file} #{mallet_options} --evaluator-filename #{evaluator_file}").run

    mallet_commands.create( :job => job, :command => "#{MALLET} import-file --keep-sequence --use-pipe-from #{training_mallet_file} --input #{validation_input_file} --output #{validation_mallet_file} --token-regex '#{TOKEN_REGEX}'").run
    mallet_commands.create( :job => job, :command => "#{MALLET} evaluate-topics --evaluator #{evaluator_file} --input #{validation_mallet_file} --output-prob #{output_prob_file}").run

    score = open( output_prob_file, "r").read.strip.to_f
    [score, validation_word_count]
  end

  def mallet_options
    "--num-topics #{num_topics} --num-iterations #{num_iterations} --optimize-burn-in #{optimize_burn_in} --alpha #{alpha} --use-symmetric-alpha #{use_symetric_burn_in ? 'TRUE' : 'FALSE'} --show-topics-interval 500 --num-top-words 20"
  end

  def make_directory( dir, job) 
    mallet_commands.create( :job => job, :command => "[ -e #{dir} ] && rm -rf #{dir}; mkdir -p #{dir}" ).run
  end

  def perplexity
    validation_score && Math.exp( -1 * validation_score)
  end

  SENTENCE_AND_WORD_SPLIT = 'python vendor/nltk/sentence_and_word_split.py'
  def split_and_tokenize_sentences

    job = "Parse"
    dir = "./tmp/mallet_run_#{id}/parse"
    make_directory( dir, job)
    
    sentence_filename = "#{dir}/sentence_file.txt"
    sentence_file = open( sentence_filename, "w")
    dataset.print_lines_to( sentence_file)
    sentence_file.close
    
    command = mallet_commands.create( :job => job, :command => "#{SENTENCE_AND_WORD_SPLIT} #{sentence_filename}" )

    command.run do |line|
      data = ActiveSupport::JSON.decode(line) rescue next
      puts "#{data['type']}:#{data['id']}"
      puts data["text"]
      puts data["tokenized"].join(" ")
      my_tokenized = []
      Tokenizer.scan( data["text"]) do |word|
        my_tokenized << word
      end
      puts my_tokenized.join(" ")
    end
  end

  
  SENTENCE_SPLIT = 'python vendor/nltk/sentence_split.py'

  def make_sentences( command)
    command.run do |line|
      data = ActiveSupport::JSON.decode(line) rescue next
      data["split"].each_with_index do |sentence, i|
        yield Sentence.new( i, data)
      end
    end
  end

  def read_output( filename)
    all_topics = lda_topics.all
    
    Zlib::GzipReader.open( filename) do |gz|
      gz.each_line do |line|
        case line
        when /^#/
          next
        else
          row = line.split(" ")
          yield row[4], all_topics[row[5].to_i]
        end
      end
    end
  end
  
  def make_labels
    job = "Labels"
    dir = "./tmp/mallet_run_#{id}/labels"
    make_directory( dir, job)
    
    output_state_filename = "./tmp/mallet_run_#{id}/output_state.gz"
    
    sentence_filename = "#{dir}/sentence_file.txt"
    sentence_file = open( sentence_filename, "w")
    dataset.print_lines_to( sentence_file)
    sentence_file.close
    
    command = mallet_commands.create( :job => job, :command => "#{SENTENCE_SPLIT} #{sentence_filename}" )

    output_state_enum = enum_for( :read_output, output_state_filename)

    top_sentences = {}
    lda_topics.all.each do |topic|
      top_sentences[topic] = TopItems.new 10
    end
    
    times_didnt_match = 0
    make_sentences( command) do |sentence|
      sentence.tokenized( stopword_list) do |word|
        output_state_word, output_state_topic = output_state_enum.peek
        
        if word != output_state_word
          times_didnt_match += 1
          puts "=================="
          puts sentence.raw
          puts sentence.data
          puts "Words don't match! #{word} != #{output_state_word}"
          if times_didnt_match > 2
            raise "Didn't match multiple times"
          end
          next
        end

        times_didnt_match = 0
        output_state_enum.next
        sentence.add_topic( output_state_topic)
      end

      top_sentences.each do |topic, top|
        top.add( sentence.score( topic), sentence)
      end
    end


    top_sentences.each do |topic, top|
      puts "=============================="
      puts topic.title
      top.each do |score, sentence|
        puts "#{score} #{sentence.raw}"
      end
    end
    nil
  end

  
  
end
