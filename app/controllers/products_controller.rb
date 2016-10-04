class ProductsController < ApplicationController
  def index
    @products = Product.all
  end
  def show
    if params[:id] =~ /^\d+$/
      @product = Product.find(params[:id])
      @images = @product.images
    else
      @product = Product.where(:slug => params[:id]).first
      raise ActiveRecord::RecordNotFound.new('Product not found') if @product.nil?
      @images = @product.images
    end

  end
  def save
  end
end
