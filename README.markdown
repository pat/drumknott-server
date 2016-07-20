## Drumknott

[![Build Status](https://travis-ci.org/pat/drumknott-server.png?branch=master)](https://travis-ci.org/pat/drumknott-server)

A simple Rails app that provides a search backend for Jekyll sites. It's available as a (cheap!) paid service at [drumknottsearch.com](https://drumknottsearch.com), but you can fire up your own instance if you wish.

It expects both PostgreSQL, Redis and Sphinx to be available, and you'll need to run both a web process (currently Puma) and a worker process (Sidekiq). Stripe is used for payment processing, and Postmark for email delivery.

### Environment Variables

Drumknott expects many environment variables to function:

* `BUGSNAG_API_KEY` for tracking errors via [Bugsnag](https://bugsnag.com).
* `DATABASE_URL` which is the primary PostgreSQL database.
* `FLYING_SPHINX_API_KEY`, `FLYING_SPHINX_HOST`, `FLYING_SPHINX_IDENTIFIER`, and `FLYING_SPHINX_PORT` courtesy of the [Flying Sphinx](http://info.flying-sphinx.com) add-on.
* `INVOICE_FROM` which has the invoice issuer details (which is likely a multi-line value including the postal address).
* `NEW_RELIC_LICENSE_KEY` for sending performance statistics to [New Relic](https://newrelic.com).
* `PAPERTRAIL_API_TOKEN` for sending logs through to [Papertrail](https://papertrailapp.com).
* `POSTMARK_API_KEY`, `POSTMARK_API_TOKEN`, and `POSTMARK_SMTP_SERVER` to manage outbound email through [Postmark](https://postmarkapp.com).
* `REDIS_URL` for the Redis service used by Sidekiq.
* `SECRET_KEY_BASE` for Rails' verification of signed cookies.
* `SIDEKIQ_USERNAME` and `SIDEKIQ_PASSWORD` to control access to Sidekiq's dashboard.
* `STRIPE_PLAN_ID` is the plan that is used for the subscription payments.
* `STRIPE_PUBLISHABLE_KEY` and `STRIPE_SECRET_KEY` are the [Stripe](https://stripe.com) API credentials.
* `STRIPE_WEBHOOK_SECRET` is used for authenticating webhook requests from Stripe.

### Contributing

Patches are very much welcome - though if you're thinking about adding in a new feature, I recommend opening up an issue on GitHub to discuss things first to check if I have any feedback on implementation details and whether the feature is likely to be merged in.

All pull requests/patches should have tests unless there's a very good reason for not including them (for example: headless browser required for javascript processing). That said, if you've got a patch in mind but not sure how to test it, create a pull request and I'll happily provide some suggestions on where to start.

Please note that this project is released with [a Contributor Code of Conduct](http://contributor-covenant.org/version/1/0/0/). By participating in this project you agree to abide by its terms.

## Licence

Copyright (c) 2016, Drumknott is developed and maintained by Pat Allan, and is
released under the open MIT Licence.
