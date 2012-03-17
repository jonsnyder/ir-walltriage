
namespace :crawl do
  desc "load the last i posts from Facebook"
  task :load_posts, [:page, :i] => [:environment] do |t, args|
    page = Page.find_by_username( args.page)
    page.fetch_posts( args.i.to_i)
  end
end
  
