require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "landing layout links" do
    get root_path
    assert_template 'landing/home'
    assert_select "a[href=?]", '#pricing'
    assert_select "a[href=?]", '#contact-us'
    assert_select "a[href=?]", sign_up_path
  end

  test 'sign up page' do
  	get sign_up_path
  	assert_template 'users/new'
    assert_select "a[href=?]", root_path
  	assert_select "a[href=?]", sign_in_path
  end
end