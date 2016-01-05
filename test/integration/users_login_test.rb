require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:uzaif)
  end

  test "user with invalid information" do
    get login_path
    assert "sessions/new"
    post login_path ,sessions:{email:"",password:""}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test "user with valid information" do
    get login_path
    assert "sessions/new"
    post login_path ,sessions:{email:@user.email,password:"123456"}
    assert_redirect_to_path @user
    follow_redirect!
    assert_template "users/show"
    assert_select "a[href=?]",login_path,count:0
    assert_select "a[href=?]",logout_path
    assert_select "a[href=?]",user_path(@user)
  end

end
