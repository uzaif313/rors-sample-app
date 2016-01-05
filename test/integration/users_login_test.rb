require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "user with invalid information" do
    get login_path
    assert "sessions/new"
    post login_path ,sessions:{email:"",password:""}
    assert_template "sessions/new"
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
end
