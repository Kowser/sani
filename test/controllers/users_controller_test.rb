require 'test_helper'

class UsersControllerTest < ActionController::TestCase
	test 'should get sign_up' do
	  get :new
	  assert_response :success
	  assert_select 'title', 'Sani | Create An Account'
	end
end