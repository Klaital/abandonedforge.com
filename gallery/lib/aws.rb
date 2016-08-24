

module Aws
  require 'time'
  require 'aws-sdk-core'
  #a init method to be used for initialisation when the rails application start
  def self.init
    @@dynamo_db = false
    @@dynamo_db = Aws::DynamoDB::Client.new
  end

  def self.query_products_from_dynamo(id=nil)
    return if !@@dynamo_db

    if id.nil?
      @@dynamo_db.scan({
          table_name: "forge-gallery-prod",
          select: "ALL_ATTRIBUTES"
      })
    else
      @@dynamo_db.get_item({
          table_name: "products",
          key: {
              'product-id' => id
          }
      })
    end
  end

end

