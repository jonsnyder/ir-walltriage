
namespace :export do
  desc "download a mallet dataset"
  task :posts, [:dataset] => [:environment] do |t, args|
    posts = Post.where( :dataset_id => args.dataset).order("created_time")
    posts.each { |post| puts post.to_mallet }
  end
end
  
