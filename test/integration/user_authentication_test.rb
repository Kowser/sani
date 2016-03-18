require 'test_helper'

class UserAuthenticationTest < ActionDispatch::IntegrationTest
  test 'should redirect to sign in page when not logged in' do
		get my_account_path
	  assert_redirected_to sign_in_url
    follow_redirect!
    assert_template 'sessions/new'
	  assert_not flash.empty?
	end
end