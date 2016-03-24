require 'test_helper'
include SessionsHelper

class UsersSignupTest < ActionDispatch::IntegrationTest
  test 'invalid signup information' do
    get sign_up_path
    assert_no_difference 'User.count' do
      post users_path, user: { first_name: '',last_name: '',
        email: 'user@invalid', password: 'foo', password_confirmation: 'bar' }
    end
    assert_template 'users/new'
  end

  test 'valid signup information' do
    get sign_up_path
    assert_difference 'User.count', 1 do
      post users_path, user: { first_name: 'Example', last_name: 'User',
        email: 'user@example.com', password: 'password', password_confirmation: 'password' }
    end
    assert is_logged_in?
    assert_redirected_to my_account_path
    follow_redirect!
    assert_select "a[href=?]", facilities_path
    assert_select "a[href=?]", my_account_path
    assert_select "a[href=?]", logout_path
  end
end