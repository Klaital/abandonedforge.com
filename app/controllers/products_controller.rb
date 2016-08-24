class ProductsController < ApplicationController
  def index
    query_response = Aws.query_products_from_dynamo
    @qty_found = query_response.count
    @products = query_response.items
  end
  def view
    query_response = Aws.query_products_from_dynamo(params[:id])
    @product = query_response.item
  end
  def save
  end
end
