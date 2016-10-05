require 'time'
class ServiceStatusController < ApplicationController
  def index
    query_start = Time.now
    @products = Product.all
    @query_timing = ((Time.now.to_f - query_start.to_f) * 1000).round
    @qty_found = @products.length 

    render :json => {
	:product_count => @qty_found,
	:db_response_ms => @query_timing,
    }
  end
end
