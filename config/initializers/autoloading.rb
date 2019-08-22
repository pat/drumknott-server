# frozen_string_literal: true

# To avoid Zeitwerk's expectations on index definitions.
ActiveSupport::Dependencies.autoload_paths.delete(
  Rails.root.join("app", "indices").to_s
)
