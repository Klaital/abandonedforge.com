

module Aws
  require 'time'
  require 'aws-sdk-core'
  #a init method to be used for initialisation when the rails application start
  def self.init
    @@dynamo_table = false
    @@dynamo_db = false
    @@dynamo_db = Aws::DynamoDB::Client.new
  end
  #the method that save in aws database
  def self.save_products_to_db(params)
    return if !@@dynamo_db
    #set the table name, hash_key and range_key from the AmazonDB
    @@dynamo_table = @@dynamo_db.tables['products']
    @@dynamo_table.hash_key = ['product-id', :string]
    #@@dynamo_table.range_key = [:datetime, :string]
    fields = {
        'product-id' => 'new-product', #primary partition key
        'created' => Time.now.utc.iso8601, #primary sort key
    }
    fields.merge!(params[:custom_fields]) if params[:custom_fields]
    @@dynamo_table.items.create(fields)
  end

  def self.query_products_from_dynamo
    return if !@@dynamo_db

    @@dynamo_db.scan({
        table_name: "forge-gallery-prod",
        select: "ALL_ATTRIBUTES"
    })
  end
end

