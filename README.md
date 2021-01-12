# README

This the repository to the now shutdown PigCI service. It has been replaced by a [standalone gem](https://github.com/PigCI/pig-ci-rails), which solves the problem without a SaaS being required.

The main purpose of this app was is connect to the GitHub API & create Check Suites, which would pass/fail a commit if the test suite reported the memory usage or amount of database requests was higher then expected.

Hopefully you find looking through the code useful! If you'd like to get contact me you can find my details on [https://mikerogers.io/](https://mikerogers.io/).

## Setup

1. Clone the repo:
2. Run `bin/setup` - This will install gems & node_modules.
3. Get local dev API credentials from GitHub, setup an app at https://github.com/settings/apps/new
4. Create a Slack Bot User & grab it's API keys. Instructions can be found https://api.slack.com/bot-users
5. Update the credentials, `bundle exec rails credentials:edit` - The `RAILS_MASTER_KEY` is set in `.env`.
6. Run `bin/setup`
7. Run `bundle exec rails s` & `bundle exec sidekiq`

### Docker

If you'd like to quickly get setup to preview the app, you can also run:

```bash
$ docker-compose build
$ docker-compose run --rm web bin/setup
$ docker-compose up
```

## Stack Notes

I had a fairly normal stack for a Rails project:

- Backend - Rails, SimpleForm & Devise
- Testing - RSpec, FactoryBot & Circle CI.
- Frontend - It used Bootstrap & Stimulus. I used the [mountain_view](https://github.com/devnacho/mountain_view) to break things into components.
- Worker - Sidekiq & Sidekiq Cron
- Administrative Panel - I used [Heroku Dataclips](https://devcenter.heroku.com/articles/dataclips) to visualise growth.
- Host - Heroku, Heroku Postgres, Heroku Redis, Papertrail & Sentry
- CDN - CloudFront
- Local Dev - I used Puma-dev, though I included a Docker setup for anyone wanting to run this.

## Credentials Format

You will need to setup a credentials file for the app to start. 

```yml
# Used as the base secret for all MessageVerifiers in Rails, including the one protecting cookies.
secret_key_base: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# https://github.com/settings/apps - Find here, this is the one for everyone.
production:
  # Slack is used for doing a daily standup so I know how the app is growing.
  slack:
    bot_user_oauth_access_token: xoxb-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx
    oauth_access_token: xoxp-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  github:
    install_url: 'https://github.com/apps/pigci/installations/new'
    marketplace_url: 'https://github.com/marketplace/pigci'
    client_id: Iv1.
    client_secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    webhook_secret: xxxxxxxxxxxxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx
    app_identifier: xxxx3
    private_key: |
      -----BEGIN RSA PRIVATE KEY-----
      -----END RSA PRIVATE KEY-----

# https://github.com/settings/apps - Setup a version for yourself locally so you don't pollute production data with local.
development:
  slack:
    bot_user_oauth_access_token: xoxb-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx
    oauth_access_token: xoxp-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  github:
    install_url: 'https://github.com/apps/pigci-localdev/installations/new'
    marketplace_url: 'https://github.com/apps/pigci-localdev/installations/new'
    client_id: Iv1.xxxxxxxxxxxxxxxx
    client_secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    webhook_secret: xxxxxxxxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx
    app_identifier: 00001
    private_key: |
      -----BEGIN RSA PRIVATE KEY-----
      -----END RSA PRIVATE KEY-----

# Test keys - Use fake keys so you never hit an API unless you really mean to.
test:
  slack:
    bot_user_oauth_access_token: xoxb-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxx
    oauth_access_token: xoxp-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
  github:
    install_url: 'https://github.com/apps/pigci-test/installations/new'
    marketplace_url: 'https://github.com/apps/pigci-test/installations/new'
    client_id: Iv1.xxxxxxxxxxxxxxxx
    client_secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
    webhook_secret: xxxxxxxxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxx-xxxxxxxxxxxxxxxxxxxxxxxx
    app_identifier: 00000
    private_key: |
      -----BEGIN RSA PRIVATE KEY-----
      -----END RSA PRIVATE KEY-----

aws:
  access_key_id: XXXXXXXXXXXXXXXXXXXX
  secret_access_key: XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
```

## Screenshots

![image](https://user-images.githubusercontent.com/325384/104367821-3c56e780-5513-11eb-9896-ec90b745e835.png)

![image](https://user-images.githubusercontent.com/325384/104367912-55f82f00-5513-11eb-8123-037ed4dd576f.png)
