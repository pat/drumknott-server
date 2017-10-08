# frozen_string_literal: true

namespace :stripe do
  desc "Update Stripe caches for all users and sites"
  task :update_caches => :environment do
    User.find_each { |user| UpdateUserCache.call user }
    Site.find_each { |site| UpdateSiteCache.call site }
  end
end
