# frozen_string_literal: true

require "rubocop/rake_task"

desc "Run RuboCop"
RuboCop::RakeTask.new(:rubocop)
