class ProductsController < ApplicationController
  def index
    query_response = Aws.query_products_from_dynamo
    @qty_found = query_response.count
    @products = query_response.items
  end
  def save
  end
end
