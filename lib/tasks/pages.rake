namespace :pages do
  task :clear_deactivated => :environment do
    RemoveDeactivatedPages.call
  end
end
