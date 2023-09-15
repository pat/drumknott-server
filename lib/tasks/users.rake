# frozen_string_literal: true

namespace :users do
  task :clear_unconfirmed => :environment do
    User.
      where(:confirmed_at => nil).
      where("created_at < ?", 1.week.ago).
      find_each(&:destroy)
  end
end
