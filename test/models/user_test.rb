require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @kit = User.new(name:'Kit', email: 'kenkaku@gmail.com',
                    password: "foobar", password_confirmation: "foobar")
  end

  test 'Kit should be valid' do
    assert @kit.valid?
  end

  test "name should be present" do
    @kit.name = '     '
    assert_not @kit.valid?
  end

  test "email should be present" do
    @kit.email = "     "
    assert_not @kit.valid?
  end

  test "name should not be too long" do
    @kit.name = "a" * 51
    assert_not @kit.valid?
  end

  test "email should not be too long" do
    @kit.email = "a" * 244 + "@example.com"
    assert_not @kit.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @kit.email = valid_address
      assert @kit.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |invalid_address|
      @kit.email = invalid_address
      assert_not @kit.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @kit.dup
    duplicate_user.email = @kit.email.upcase
    @kit.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @kit.email = mixed_case_email
    @kit.save
    assert_equal mixed_case_email.downcase, @kit.reload.email
  end

  test "password should be present (nonblank)" do
    @kit.password = @kit.password_confirmation = " " * 6
    assert_not @kit.valid?
  end

  test "password should have a minimum length" do
    @kit.password = @kit.password_confirmation = "a" * 5
    assert_not @kit.valid?
  end
end
