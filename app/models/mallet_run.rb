class MalletRun < ActiveRecord::Base
  belongs_to :dataset
  has_many :mallet_commands

  def run
    mallet_commands.destroy_all
    
    dir = "./tmp/mallet_run_#{id}"
    input_file = dir + "/input.txt"
    mallet_file = dir + "/input.mallet"
    token_regex = '[^\s]+'
    output_doc_topics = dir + "/output_doc_topics.txt"
    word_topic_counts_file = dir + "/word_topic_counts_file.txt"

    
    mallet_commands.create( :command => "rm -rf #{dir}; mkdir #{dir}").run
    
    dataset.to_mallet_file( input_file)
    
    mallet_commands.create( :command => "./vendor/mallet/bin/mallet import-file --keep-sequence --input #{input_file} --output #{mallet_file} --token-regex '#{token_regex}' --remove-stopwords TRUE").run
    mallet_commands.create( :command => "./vendor/mallet/bin/mallet train-topics --input #{mallet_file} --num-topics #{num_topics} --num-iterations #{num_iterations} --optimize-burn-in #{optimize_burn_in} --use-symmetric-alpha #{use_symetric_burn_in ? 'TRUE' : 'FALSE'} --show-topics-interval 500 --output-doc-topics #{output_doc_topics} --word-topic-counts-file #{word_topic_counts_file} --output-state #{dir}/output_state.txt --output-topic-keys #{dir}/output_topic_keys.txt --topic-word-weights-file #{dir}/topic_word_weights_file.txt --xml-topic-report #{dir}/xml_topic_report.xml --xml-topic-phrase-report #{dir}/xml_topic_phrase_report.xml").run

    # parse the output files here
  end
end
