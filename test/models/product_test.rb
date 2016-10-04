require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  test "slugs must be unique" do
    p1 = Product.new(:name => 'Test Product 1', :slug => 'tp')
    p1.save
    assert p1.valid?
    p2 = Product.new(:name => 'Test Product 2', :slug => 'tp1')
    assert_not(p2.valid?)

    p2.slug = 'tp3'
    assert(p2.valid?)
  end
end
