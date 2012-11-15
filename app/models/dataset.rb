class Dataset < ActiveRecord::Base
  has_many :posts, :dependent => :destroy, :include => :comments
  has_many :stopword_lists, :dependent => :destroy
  
  def copy_posts_into_dataset( posts)
    Dataset.transaction do
      posts.each do |post|
        new_post = post.dup
        new_post.dataset = self
        new_post.save
        post.comments.each do |comment|
          new_comment = comment.dup
          new_comment.post = new_post
          new_comment.save
        end
      end
    end
  end

  def to_mallet_file( filename, input_posts=nil)
    input_posts ||= posts
    File.open( filename, 'w') do |f|
      input_posts.each do |p|
        f.puts p.to_mallet { |word| yield word }
      end
    end
  end

  def print_lines_to( file)
    posts.each do |p|
      p.print_lines_to( file)
    end
  end
  
  def k_fold_cross_validation_sets( k)
    partitions = partition(k)
    partitions.each_with_index do |validation_set, i|
      training_set = ((i > 0) ? partitions[0..i-1] : []) + ((i < 10) ? partitions[i+1..k-1] : [])
      training_set.flatten!
      yield i, training_set, validation_set
    end
    nil
  end

  def partition( k)
    partitions = []
    posts.all.sort_by { rand }.each_slice( posts.size / k) { |slice| partitions << slice }
    if partitions.length > k
      partitions[k..partitions.length-1].flatten.each_with_index do | post, i|
        partitions[i] << post
      end
      partitions = partitions[0..k-1]
    end
    partitions
  end

  def df
    df = WordFrequency.new
    
    posts.each do |post|
      tf = WordFrequency.new
      post.tokenized { |word| true }.each do |word|
        if !word.blank?
          tf.add( word)
        end
      end
      tf.words.each do |word|
        df.add( word)
      end
    end
    df
  end

  
end
