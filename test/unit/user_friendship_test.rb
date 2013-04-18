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
		assert users(:usman).pending_friends.include?(users(:mike))
	end

	context "a new instance" do
		setup do
			@user_friendship = UserFriendship.new user: users(:usman), friend: users(:mike)
		end

		should "have a pending state" do
			assert_equal 'pending', @user_friendship.state
		end
	end

	context "#send_request_email" do
		setup do
			@user_friendship = UserFriendship.new user: users(:usman), friend: users(:mike)
		end

		should "send an email" do
			assert_difference 'ActionMailer::Base.deliveries.size', 1 do
				@user_friendship.send_request_email
			end
		end
	end

	context "#accept!" do
		setup do
			@user_friendship = UserFriendship.new user: users(:usman), friend: users(:mike)
		end

		should	"set the state to accepted" do
			@user_friendship.accept!
			assert_equal "accepted", @user_friendship.state
		end

		should "send a accepted email" do
			assert_difference 'ActionMailer::Base.deliveries.size', 1 do
				@user_friendship.accept!
			end
		end

		should "include the friend in the list of friends" do
			@user_friendship.accept!
			users(:usman).friends.reload
			assert users(:usman).friends.include?(users(:mike))
		end
	end

	context ".request" do
		should "create two user friendships" do
			assert_difference 'UserFriendship.count', 2 do
				UserFriendship.request(users(:usman), users(:mike))
			end
		end

		should "send a friend request email" do
			assert_difference 'ActionMailer::Base.deleveries.size', 1 do
				UserFriendship.request(users(:usman), users(:mike))
			end
		end
	end
end
