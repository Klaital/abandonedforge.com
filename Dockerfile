FROM rails
MAINTAINER Chris Cox <chriscox@abandonedfactory.net>

RUN apt-get update && \
    apt-get install -y net-tools

ADD Gemfile* ./
RUN gem install bundler && \
    bundle install

# Create the directory structure
RUN mkdir -p lib/assets \
             lib/tasks  \
             bin        \
             config/locales \
             config/initializers \
             config/environments \
             app/assets/images \
             app/assets/stylesheets \
             app/assets/javascripts \
             app/helpers \
             app/mailers \
             app/views/layouts \
             app/views/products \
             app/views/service_status \
             app/views/pages/page_content \
             app/models/concerns \
             app/controllers/concerns \
             test/helpers \
             test/mailers \
             test/integration \
             test/models \
             test/fixtures \
             test/controllers \
             vendor/assets/stylesheets \
             vendor/assets/javascripts \
             log \
             tmp/sessions \
             tmp/sockets \
             tmp/pids \
             tmp/cache/assets/sprockets/v3.0 \
             public \
             db/migrate

# Add the binaries first, they won't change unless Rails is upgraded
COPY bin/setup bin/
COPY bin/rails bin/
COPY bin/spring bin/
COPY bin/bundle bin/
COPY bin/rake bin/

# Other framework stuff next
COPY db/seeds.rb db/
COPY db/schema.rb db/
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
COPY prod_secret.txt ./
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
COPY config/initializers/cookies_serializer.rb config/initializers/
COPY config/initializers/inflections.rb config/initializers/
COPY config/initializers/mime_types.rb config/initializers/
COPY config/application.rb config/
COPY config/secrets.yml  config/
COPY config/environment.rb config/

# Libraries

# Tests
COPY test/test_helper.rb test/
COPY test/controllers/products_controller_test.rb test/

# Application code
COPY app/assets/javascripts/*.js app/assets/javascripts/
COPY app/assets/javascripts/*.coffee app/assets/javascripts/
COPY app/assets/stylesheets/*.css app/assets/stylesheets/
COPY app/assets/stylesheets/*.scss app/assets/stylesheets/
COPY app/assets/images/*.* app/assets/images/

COPY app/helpers/application_helper.rb app/helpers/
COPY app/helpers/products_helper.rb app/helpers/
COPY app/helpers/sessions_helper.rb app/helpers/
COPY app/helpers/users_helper.rb app/helpers/

COPY app/views/layouts/application.html.erb app/views/layouts/
COPY app/views/layouts/_header.html.erb app/views/layouts/
COPY app/views/layouts/_footer.html.erb app/views/layouts/
COPY app/views/layouts/_navbar.html.erb app/views/layouts/
COPY app/views/pages/show.html.erb app/views/pages
COPY app/views/pages/page_content/_aboutme.html.erb app/views/pages/page_content
COPY app/views/products/index.html.erb app/views/products/
COPY app/views/products/show.html.erb app/views/products/
COPY app/views/service_status/index.html.erb app/views/service_status/
COPY app/views/sessions/new.html.erb app/views/sessions/
COPY app/views/users/new.html.erb app/views/users/
COPY app/views/users/show.html.erb app/views/users/

COPY app/controllers/application_controller.rb app/controllers/
COPY app/controllers/products_controller.rb app/controllers/
COPY app/controllers/service_status_controller.rb app/controllers/
COPY app/controllers/users_controller.rb app/controllers/
COPY app/controllers/pages_controller.rb app/controllers/
COPY app/controllers/sessions_controller.rb app/controllers/

COPY app/models/application_record.rb app/models/
COPY app/models/user.rb app/models/
COPY app/models/product.rb app/models/
COPY app/models/product_material.rb app/models/
COPY app/models/image.rb app/models/
COPY app/models/image_tag.rb app/models/

COPY app/controllers/sessions_controller.rb app/controllers/
COPY app/views/sessions/new.html.erb app/views/sessions/
COPY app/helpers/sessions_helper.rb app/helpers/

# Start the server
EXPOSE 3000
ENV RAILS_ENV=production
RUN rails assets:precompile
ENTRYPOINT [ "sh", "-c", "SECRET_KEY_BASE=`cat prod_secret.txt` RAILS_ENV=production rails s" ]
