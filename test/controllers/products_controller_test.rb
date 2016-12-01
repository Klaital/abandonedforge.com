require 'test_helper'

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @product = products(:weed_puller)
    @user = users(:one)
    @user2 = users(:two)
  end

  test "should get index" do
    get products_url
    assert_response :success
  end

  test "should show product" do
    get product_url(@product)
    assert_response :success
    end

  test "should get new when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    get new_product_url
    assert_response :success
  end

  test "should not get new when not logged in" do
    get new_product_url
    assert_redirected_to login_path
  end

  test "should create product when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    assert_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, name: @product.name, price: @product.price, product_image_size: @product.product_image_size, product_image_url: @product.product_image_url, stock: @product.stock, thumbnail_size: @product.thumbnail_size, thumbnail_url: @product.thumbnail_url } }
    end

    assert_redirected_to product_url(Product.last)
  end
  test "should not create product when not logged in" do
    assert_no_difference('Product.count') do
      post products_url, params: { product: { description: @product.description, name: @product.name, price: @product.price, product_image_size: @product.product_image_size, product_image_url: @product.product_image_url, stock: @product.stock, thumbnail_size: @product.thumbnail_size, thumbnail_url: @product.thumbnail_url } }
    end

    assert_response(401)
  end


  test "should get edit when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    get edit_product_url(@product)
    assert_response :success
  end
  test "should not get edit when not logged in" do
    get edit_product_url(@product)
    assert_redirected_to login_path
  end

  test "should not get edit when not logged in as the owner" do
    get edit_product_url(@product)
    assert_redirected_to login_path
  end

  test "should update product when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    patch product_url(@product), params: { product: { description: @product.description, name: @product.name, price: @product.price, product_image_size: @product.product_image_size, product_image_url: @product.product_image_url, stock: @product.stock, thumbnail_size: @product.thumbnail_size, thumbnail_url: @product.thumbnail_url } }
    assert_redirected_to product_url(@product)
  end
  test "should not update product when not logged in" do
    patch product_url(@product), params: { product: { description: @product.description, name: @product.name, price: @product.price, product_image_size: @product.product_image_size, product_image_url: @product.product_image_url, stock: @product.stock, thumbnail_size: @product.thumbnail_size, thumbnail_url: @product.thumbnail_url } }
    assert_response(401)
  end
  test "should not update product when not logged in as the owner" do
    post login_path, params: {session: {email: @user2.email, password: 'foobar'}}
    patch product_url(@product), params: { product: { description: @product.description, name: @product.name, price: @product.price, product_image_size: @product.product_image_size, product_image_url: @product.product_image_url, stock: @product.stock, thumbnail_size: @product.thumbnail_size, thumbnail_url: @product.thumbnail_url } }
    assert_response(401)
  end

  test "should destroy product when logged in" do
    post login_path, params: {session: {email: @user.email, password: 'foobar'}}
    assert_difference('Product.count', -1) do
      delete product_url(@product)
    end

    assert_redirected_to products_url
  end
  test "should not destroy product when not logged in" do
    assert_no_difference('Product.count') do
      delete product_url(@product)
    end

    assert_response(401)
  end
  test "should not destroy product when not logged in as the owner" do
    post login_path, params: {session: {email: @user2.email, password: 'foobar'}}
    assert_no_difference('Product.count') do
      delete product_url(@product)
    end

    assert_response(401)
  end
end
