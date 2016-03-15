require 'test_helper'

class LandingControllerTest < ActionController::TestCase
  test 'should get home' do
    get :home
    assert_response :success
    assert_select 'title', 'Sani | Residential Care Management'
  end
end