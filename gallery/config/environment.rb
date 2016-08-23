# Load the Rails application.
require 'yaml'
require File.expand_path('../application', __FILE__)

AWS_SETTINGS = YAML.load_file("#{Rails.root}/config/aws_dynamo.yml")
ENV['AWS_REGION'] = AWS_SETTINGS['aws_dynamo']['region']
ENV['AWS_ACCESS_KEY_ID'] = AWS_SETTINGS['aws_dynamo']['access_key_id']
ENV['AWS_SECRET_ACCESS_KEY'] = AWS_SETTINGS['aws_dynamo']['secret_access_key']

# Initialize the Rails application.
Rails.application.initialize!
Aws.init


