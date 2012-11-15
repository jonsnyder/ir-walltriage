
namespace :test do
  task :sentence => :environment do 
    sentences = 
    [ "Hello World.  I really like the product.  Good morning Mr. Hi.",
      "Good day, sir.",
      "Hello" ]

    writer = lambda do |stdin|
      sentences.each do |line|
        stdin.puts line
      end
      stdin.close
    end
    run = MalletRun.find(1).mallet_commands.create( :job => "Label", :command => "python vendor/nltk/sentence_split.py")
    run.run(writer ) { |line| puts line }

  end
end
  
