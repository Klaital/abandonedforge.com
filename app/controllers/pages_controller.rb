class PagesController < ApplicationController
  def show
    raise ActionController::RoutingError.new('Page Not Found') unless params[:id]
  end
end