namespace :stripe do
  task :update_caches => :environment do
    User.find_each { |user| UpdateUserCache.call user }
    Site.find_each { |site| UpdateSiteCache.call site }
  end
end
