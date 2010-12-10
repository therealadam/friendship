require "friendship"
require "redis"

redis = Redis.new
Friendship.use(Friendship::Storage::RedisSets, redis)

Friendship.follow("paul", "john")
Friendship.follow("paul", "george")
Friendship.follow("paul", "ringo")

Friendship.follow("john", "paul")
Friendship.follow("john", "george")
Friendship.follow("john", "ringo")

p Friendship.friendships("paul")
p Friendship.friend_of?("paul", "ringo")
p Friendship.mutual_friends("john", "paul")

