class Strategy < ActiveRecord::Base

  belongs_to :mallet_run
  has_many :lda_post_tags
  has_many :stat_values
  
  serialize :options, Hash
  after_create :run_and_compute_stats_async

  def tagged_posts
    lda_post_tags.select('distinct post_id').count
  end

  def tags
    lda_post_tags.count
  end

  def unique_tags
    lda_post_tags.select('distinct lda_topic_id').count
  end

  def run_and_compute_stats_async
    Delayed::Job.enqueue DelayedJob.new( id, type, :run_and_compute_stats, [])
  end
  
  def run_and_compute_stats
    run
    compute_stats
  end
  
  def compute_stats
    stat_values.delete_all
    
    system_matcher = Matcher::LdaPostTags.new( self)
    post_ids = mallet_run.dataset.post_ids
    
    AccessToken.where(:use_for_stats => true).each do |user|

      user_matcher = Matcher::UserPostTags.new( user.id)
      
      kappa = CohenKappa.new( post_ids, system_matcher, user_matcher)
      kappa.calculate
      
      stat_values.create( :stat => Stat.kappa, :access_token => user, :value => fix( kappa.score))
      stat_values.create( :stat => Stat.precision, :access_token => user, :value => fix( kappa.precision))
      stat_values.create( :stat => Stat.recall, :access_token => user, :value => fix( kappa.recall))
    end

    tf_idfs = TfIdfCalculator.new( mallet_run.dataset.posts).calculate
    cs = CosineSimularity.new( tf_idfs, system_matcher).calculate
    stat_values.create( :stat => Stat.cosine_simularity, :value => (cs[0] / cs[1])) 
  end

  def fix( value)
    if value == NaN
      nil
    else
      value
    end
  end
  
end
