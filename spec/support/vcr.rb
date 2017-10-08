# frozen_string_literal: true

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr'
  config.hook_into :webmock
end

VCRAssistant.assistant = lambda { |label, vcr_cassette|
  StripeAssistant.new vcr_cassette
}
