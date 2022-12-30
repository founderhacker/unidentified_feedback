# Unidentified Feedback
simple app that turns anonymous feedback into [Tweets](https://twitter.com/unidentified_ft) for all to see. learn how to build this at [24 Hour MVP](https://founderhacker.com/24-hour-mvp).

## Installation
1. clone the repo
2. `cd <project> && bundle`
3. `rails db:setup && rails db:migrate`
4. `bundle exec figaro install`
5. `cp config/application-sample.yml config/application.yml` and set values**

** Stripe configs are optional; leave them as-is to ignore this feature. To test the mailer,  `admin_email` and `admin_password` must belong to a Gmail account.

## Development
```
bin/dev # uses foreman gem to boot server + frontend
```

**Troubleshooting**

`Application-specific password required. Learn more at (Net::SMTPAuthenticationError)`
you likely have 2-factor auth enabled on your supplied Gmail account. Make an app-specific password [here](https://security.google.com/settings/security/apppasswords) or learn more [here](https://stackoverflow.com/a/28596570).

## Deploying
install the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) and run `heroku login`. if repo admin has shared access to the server:

```
heroku git:remote -a heroku_app_name_here # you only need to do this once
git push heroku master # deploys master branch
git push heroku some_branch_name:master # deploys non-master branch
```

## Production management
to access the Rails console on the production server:
```
heroku run rails console
```
to add or update environment variables from your local `config/application.yml` file:
```
figaro heroku:set -e production
```
