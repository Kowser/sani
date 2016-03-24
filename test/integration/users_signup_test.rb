require 'test_helper'
include SessionsHelper

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup information' do
    get sign_up_path
    assert_no_difference 'User.count' do
      post users_path, user: { first_name: '',last_name: '',
        email: 'user@invalid', password: 'foo', password_confirmation: 'bar' }
    end
    assert_template 'users/new'
  end

  test "valid signup information with account activation" do
    get sign_up_path
    assert_difference 'User.count', 1 do
      post users_path, user: { first_name: 'Example', last_name: 'User',
        email: 'user@example.com', password: 'password', password_confirmation: 'password' }
    end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?
    # Try to log in before activation.
    log_in_as(user)
    assert_not is_logged_in?
    # Invalid activation token
    get account_activation_path('invalid token')
    assert_not is_logged_in?
    # Valid token, wrong email
    get account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?
    # Valid activation token
    get account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    assert_redirected_to my_account_path
    follow_redirect!
    assert is_logged_in?
    assert_select "a[href=?]", facilities_path
    assert_select "a[href=?]", my_account_path
    assert_select "a[href=?]", logout_path
  end
end