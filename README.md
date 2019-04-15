[![Build Status](https://dfe-ssp.visualstudio.com/Become-A-Teacher/_apis/build/status/Find/manage-courses-support?branchName=master)](https://dfe-ssp.visualstudio.com/Become-A-Teacher/_build/latest?definitionId=47&branchName=master) [![Greenkeeper badge](https://badges.greenkeeper.io/DFE-Digital/manage-courses-support.svg)](https://greenkeeper.io/)

# Support teacher training publishers

This app is used by the user support team to help publishers with the Pubish teacher training courses service.

## Prerequisites

- Ruby 2.6.1
- postgresql-9.6 postgresql-contrib-9.6

## Setting up the app in development

1. Run `yarn` to install node dependencies
2. Run `bundle install` to install the gem dependencies
3. Run `rake db:setup` to set up the database development and test schemas, and seed with test data
4. Run `bundle exec foreman start -f Procfile.dev` to launch the app on http://localhost:5000

## Testing features that depend on the Manage Courses API

Some features of this app interact with the Manage Courses API. For development, this can be stubbed locally:

1. Run `rackup mock_manage_courses_api.ru` which starts a mock API on `localhost` port 9292.
2. Run the development server with `MANAGE_API_BASE_URL=http://localhost:9292 rails s` so it points at the mock.

## Sentry

To track exceptions through Sentry, configure the `SENTRY_DSN` environment variable:

```
SENTRY_DSN=https://aaa:bbb@sentry.io/123 rails s
```
