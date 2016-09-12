FROM rails
MAINTAINER Chris Cox <chriscox@abandonedfactory.net>

RUN apt-get update && \
    apt-get install -y net-tools

ADD Gemfile* ./
RUN bundle install

RUN mkdir -p lib/assets
RUN mkdir -p lib/tasks
RUN mkdir -p bin
RUN mkdir -p config/locales
RUN mkdir -p config/initializers
RUN mkdir -p config/environments

RUN mkdir -p ./app/assets/images
RUN mkdir -p ./app/assets/stylesheets
RUN mkdir -p ./app/assets/javascripts
RUN mkdir -p ./app/helpers
RUN mkdir -p ./app/mailers
RUN mkdir -p ./app/views/layouts
RUN mkdir -p ./app/views/products
RUN mkdir -p ./app/views/service_status
RUN mkdir -p ./app/models/concerns
RUN mkdir -p ./app/controllers/concerns
RUN mkdir -p ./test/helpers
RUN mkdir -p ./test/mailers
RUN mkdir -p ./test/integration
RUN mkdir -p ./test/models
RUN mkdir -p ./test/fixtures
RUN mkdir -p ./test/controllers
RUN mkdir -p ./vendor/assets/stylesheets
RUN mkdir -p ./vendor/assets/javascripts
RUN mkdir -p ./log
RUN mkdir -p ./tmp/sessions
RUN mkdir -p ./tmp/sockets
RUN mkdir -p ./tmp/pids
RUN mkdir -p ./tmp/cache/assets/sprockets/v3.0
RUN mkdir -p ./public
RUN mkdir -p ./db

# Add the binaries first, they won't change unless Rails is upgraded
COPY bin/setup bin/
COPY bin/rails bin/
COPY bin/spring bin/
COPY bin/bundle bin/
COPY bin/rake bin/

# Other framework stuff next
COPY db/seeds.rb db/
COPY config.ru ./
COPY Gemfile ./
COPY Gemfile.lock ./
COPY Rakefile ./

# Static files
COPY public/422.html public/
COPY public/500.html public/
COPY public/favicon.ico public/
COPY public/404.html public/
COPY public/robots.txt public/

# Config stuff
COPY config/environments/test.rb config/environments/
COPY config/environments/development.rb config/environments/
COPY config/environments/production.rb config/environments/
COPY config/routes.rb config/
COPY config/boot.rb config/
COPY config/database.yml config/
COPY config/aws_dynamo.yml config/
COPY config/locales/en.yml config/locales/
COPY config/initializers/session_store.rb config/initializers/
COPY config/initializers/assets.rb config/initializers/
COPY config/initializers/wrap_parameters.rb config/initializers/
COPY config/initializers/backtrace_silencers.rb config/initializers/
COPY config/initializers/filter_parameter_logging.rb config/initializers/
COPY config/initializers/aws.rb config/initializers/
COPY config/initializers/cookies_serializer.rb config/initializers/
COPY config/initializers/inflections.rb config/initializers/
COPY config/initializers/mime_types.rb config/initializers/
COPY config/application.rb config/
COPY config/secrets.yml  config/
COPY config/environment.rb config/

# Libraries
# This includes our custom code for DynamoDb connectivity, so it will be updated alongside the application code.
COPY lib/aws.rb lib/

# Tests
COPY test/test_helper.rb test/
COPY test/controllers/products_controller_test.rb test/

# Application code
COPY app/assets/stylesheets/products.scss app/assets/stylesheets/
COPY app/assets/stylesheets/application.css app/assets/stylesheets/
COPY app/assets/stylesheets/gallery.css app/assets/stylesheets/
COPY app/assets/javascripts/products.coffee app/assets/javascripts/
COPY app/assets/javascripts/application.js app/assets/javascripts/
COPY app/helpers/application_helper.rb app/helpers/
COPY app/helpers/products_helper.rb app/helpers/
COPY app/views/layouts/application.html.erb app/views/layouts/
COPY app/views/products/index.html.erb app/views/products/
COPY app/views/products/show.html.erb app/views/products/
COPY app/views/service_status/index.html.erb app/views/service_status/
COPY app/controllers/application_controller.rb app/controllers/
COPY app/controllers/products_controller.rb app/controllers/
COPY app/controllers/service_status_controller.rb app/controllers/
COPY app/controllers/users_controller.rb app/controllers/
COPY app/models/users.rb app/models/
COPY app/models/products.rb app/models/
COPY app/models/images.rb app/models/

# Start the server
EXPOSE 3000
ENTRYPOINT [ "bin/rails", "server", "-b", "0.0.0.0" ]
