require 'test_helper'

class LandingControllerTest < ActionController::TestCase
  test 'should get home' do
    get :home, 'home'
    assert_response :success
    assert_select 'title', 'Sani | Residential Care Management'
  end

  test 'should get sign_up' do
    get :sign_up, 'sign_up'
    assert_response :success
    assert_select 'title', 'Sani | Create an Account'
  end
end