require "friendship"
require "redis"

redis = Redis.new
Friendship.use(Friendship::Storage::RedisSets, redis)

Friendship.friend("paul", "john")
Friendship.friend("paul", "george")
Friendship.friend("paul", "ringo")

Friendship.friend("john", "paul")
Friendship.friend("john", "george")
Friendship.friend("john", "ringo")

p Friendship.friendships("paul")
p Friendship.friend_of?("paul", "ringo")
p Friendship.mutual_friends("john", "paul")

