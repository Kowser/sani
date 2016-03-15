require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "landing layout links" do
    get root_path
    assert_template 'landing/home'
    assert_select "a[href=?]", '#why-sani'
    assert_select "a[href=?]", '#pricing'
    assert_select "a[href=?]", '#about-us'
    assert_select "a[href=?]", '#contact-us'
    assert_select "a[href=?]", sign_up_path
    # assert_select "a[href=?]", root_path #logo?
  end
end