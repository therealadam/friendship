module Friendship::Storage

  autoload :Cassandra, "friendship/storage/cassandra"
  autoload :RedisLists, "friendship/storage/redis_lists"
  autoload :RedisSets, "friendship/storage/redis_sets"

end
