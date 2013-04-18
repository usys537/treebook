require 'test_helper'

class AddAFriendTest < ActionDispatch::IntegrationTest
	def sign_in_as(user, password)
		post login_path, user: { email: user.email, password: password}
	end

	test "that adding a friend works" do  
		sign_in_as users(:usman), "testing"

		get "/user_friendships/new?friend_id=#{users(:usman2).profile_name}"
		assert_response :success		

		assert _difference "UserFriendship.count" do 
			post "/user_friendships", user_friendship: { friend_id: users(:usman).profile_name }
			assert_response :redirect
			assert_equal "you are now friends with #{users(:usman2).full_name}", flash[:success]
		end
	end
end
