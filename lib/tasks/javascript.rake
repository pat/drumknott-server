# frozen_string_literal: true

namespace :javascript do
  task :release do
    version = File.read(Rails.root.join("public", "VERSION")).strip
    `coffee -c -o public app/assets/javascripts/drumknott.coffee`
    `cp public/drumknott.js public/drumknott-#{version}.js`
  end
end
