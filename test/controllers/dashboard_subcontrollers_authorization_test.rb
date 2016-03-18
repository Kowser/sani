require 'test_helper'
# paths require a facility_id, and/or an object :id to be valid

class Dashboard::EmploymentApplicationsControllerTest < ActionController::TestCase
	test "should redirect all views when not logged in" do
    post :index, facility_id: 1
    assert_redirected_to sign_in_url
    get :show, facility_id: 1, id: 1
    assert_redirected_to sign_in_url
    post :update, facility_id: 1, id: 1
    assert_redirected_to sign_in_url
  end
end

class Dashboard::FacilitiesControllerTest < ActionController::TestCase
	test "should redirect all views when not logged in" do
    get :index, facility_id: 1
    assert_redirected_to sign_in_url
    get :new, facility_id: 1
    assert_redirected_to sign_in_url
    get :edit, facility_id: 1, id: 1
    assert_redirected_to sign_in_url
    post :create, facility_id: 1
    assert_redirected_to sign_in_url
    post :update, facility_id: 1, id: 1
    assert_redirected_to sign_in_url
  end
end

class Dashboard::ResidentsControllerTest < ActionController::TestCase
	test "should redirect all views when not logged in" do
    get :index, facility_id: 1
    assert_redirected_to sign_in_url
    get :new, facility_id: 1
    assert_redirected_to sign_in_url
    get :edit, facility_id: 1, id: 1
    assert_redirected_to sign_in_url
    post :create, facility_id: 1
    assert_redirected_to sign_in_url
    post :update, facility_id: 1, id: 1
    assert_redirected_to sign_in_url
  end
end