require 'aws-sdk'

AWS_SETTINGS = YAML.load_file("#{Rails.root}/config/aws_dynamo.yml")
ENV['AWS_REGION'] = AWS_SETTINGS['aws_dynamo']['region']
ENV['AWS_ACCESS_KEY_ID'] = AWS_SETTINGS['aws_dynamo']['aws_access_token']
ENV['AWS_SECRET_ACCESS_KEY'] = AWS_SETTINGS['aws_dynamo']['aws_secret_access_key']

Aws.config.update({
    region: AWS_SETTINGS['aws_dynamo']['region'],
    credentials: Aws::Credentials.new(
        AWS_SETTINGS['aws_dynamo']['aws_access_token'],
        AWS_SETTINGS['aws_dynamo']['aws_secret_access_key']
    )
                  })

Dynamoid.configure do |config|
  config.adapter = 'aws_sdk_v2'
  config.namespace = 'aforge'
  config.warn_on_scan = true
  config.read_capacity = 5
  config.write_capacity = 5
end