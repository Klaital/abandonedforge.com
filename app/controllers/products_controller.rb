class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    unless logged_in?
      flash.now[:warning] = 'Please log in to a creator account create products.'
      redirect_to login_path and return
    end
    @product = current_user.products.create
  end

  # GET /products/1/edit
  def edit
    unless logged_in? && current_user == @product.user
      flash.now[:warning] = 'Please log in to a creator account create products.'
      redirect_to login_path and return
    end
  end

  # POST /products
  # POST /products.json
  def create
    unless logged_in?
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    @product = current_user.products.create(product_params)

    respond_to do |format|
      if @product.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    unless logged_in? && current_user == @product.user
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    unless logged_in? && current_user == @product.user
      render :file => 'public/401', :status => :unauthorized, :layout => false and return
    end
    @product.destroy
    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params.require(:product).permit(:name, :thumbnail_url, :thumbnail_size, :product_image_url, :product_image_size, :stock, :price, :description)
    end
end
