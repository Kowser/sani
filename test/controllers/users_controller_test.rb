require 'test_helper'

class Landing::UsersControllerTest < ActionController::TestCase
	test 'should get sign_up' do
	  get :new
	  assert_response :success
	  assert_select 'title', 'Sani | Create An Account'
	end
end

# class Dashboard::UsersControllerTest < ActionController::TestCase
	# test "should redirect edit when logged in as wrong user" do
	#   log_in_as(@other_user)
	#   get :edit, id: @user
	#   assert flash.empty?
	#   assert_redirected_to root_url
	# end

	# test "should redirect update when logged in as wrong user" do
	#   log_in_as(@other_user)
	#   patch :update, id: @user, user: { name: @user.name, email: @user.email }
	#   assert flash.empty?
	#   assert_redirected_to root_url
	# end
# end