# frozen_string_literal: true

namespace :javascript do
  # rubocop:disable Rails/RakeEnvironment
  task :release do
    version = File.read(Rails.public_path.join("VERSION")).strip
    `coffee -c -o public app/assets/javascripts/drumknott.coffee`
    `cp public/drumknott.js public/drumknott-#{version}.js`
  end
  # rubocop:enable Rails/RakeEnvironment
end
