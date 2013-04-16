require 'test_helper'

class UserFriendshipTest < ActiveSupport::TestCase
	should belong_to(:user)
	should belong_to(:friend)

	test "that creating a friendship works without rasing an exception"   do
	  assert_nothing_raised do 
		UserFriendshipTest.create user:users(:usman), friend: users(:Mike)	
	  end 	
	end

	test "that creating a friendship based on user id and friend id works" do
		UserFriendship.create user_id: users(:usman).id, friend_id: users(:mike).id
		assert users(:usman).friends.include?(users(:mike))
	end

end
