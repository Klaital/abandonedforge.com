require 'time'
class ServiceStatusController < ApplicationController
  def index
    query_start = Time.now
    query_response = Aws.query_products_from_dynamo
    @query_timing = ((Time.now.to_f - query_start.to_f) * 1000).round
    @qty_found = query_response.count
  end
end
