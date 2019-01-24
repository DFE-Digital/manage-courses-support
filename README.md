# Support teacher training publishers

This app is used by the user support team to help publishers with the Pubish teacher training courses service.

## Setting up the app in development

1. Run `yarn` to install node dependencies
2. Run `bundle install` to install the gem dependencies
3. Run `rake db:setup` to set up the database development and test schemas, and seed with test data
4. Run `bundle exec foreman start -f Procfile.dev` to launch the app on http://localhost:5000

## Testing features that depend on the Manage Courses API

Some features of this app interact with the Manage Courses API. For development, this can be stubbed locally:

1. Run `rackup mock_manage_courses_api.ru` which starts a mock API on `localhost` port 9292.
2. Run the development server with `MANAGE_API_BASE_URL=http://localhost:9292 rails s` so it points at the mock.
