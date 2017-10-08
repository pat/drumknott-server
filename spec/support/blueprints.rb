# frozen_string_literal: true

require "machinist/active_record"

Site.blueprint do
  name   { "site#{sn}" }
  user   { object.user || User.make! }
  status { "active" }
end

User.blueprint do
  email                 { "search#{sn}@drumknottsearch.com" }
  password              { "password" }
  password_confirmation { object.password }
end
