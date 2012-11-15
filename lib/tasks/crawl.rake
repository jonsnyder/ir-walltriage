
namespace :crawl do
  desc "load the last i posts from Facebook"
  task :load_posts, [:page, :i] => [:environment] do |t, args|
    page = Page.find_by_username( args.page)
    page.fetch_posts( args.i.to_i)
  end

  desc "load the last x days of posts from Facebook"
  task :load_posts_by_days, [:page, :days] => [:environment] do |t, args|
    page = Page.find_by_username( args.page)
    page.fetch_posts_by_days( args.days.to_i)
  end
  
  desc "update the all the posts of a given page that aren't part of a dataset"
  task :update_posts, [:page] => [:environment] do |t, args|
    page = Page.find_by_username( args.page)
    page.update_posts
  end

end
  
