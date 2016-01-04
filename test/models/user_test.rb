require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user=User.new name:"Tmp User",email:"tmp@gmail.com",
                   password: "foobar", password_confirmation: "foobar"
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "name should be present" do
    @user.name="a"*51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email="a"*244+"@example.com"
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password=@user.password_confirmation=" "*6
    assert_not @user.valid?
  end

  test "password should have minimum length" do
    @user.password=@user.password_confirmation="a"*5
    assert_not @user.valid?
  end
end
