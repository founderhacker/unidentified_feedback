# Unidentified Feedback
simple app that turns anonymous feedback into [Tweets](https://twitter.com/unidentified_ft) for all to see. learn how to build this at [24 Hour MVP](https://founderhacker.com/24-hour-mvp).

## Installation
1. clone the repo
2. `cd <project> && bundle`
3. `rails db:setup && rails db:migrate`
4. `bundle exec figaro install`
5. get `config/application.yml` values from repo admin

## Development
```
bin/dev # uses foreman gem to boot server + frontend
```

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
