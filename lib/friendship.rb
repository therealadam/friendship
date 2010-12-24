require "active_support/core_ext/module"

module Friendship

  mattr_accessor :storage

  module Storage

    autoload :Cassandra, "friendship/storage/cassandra"
    autoload :RedisLists, "friendship/storage/redis_lists"
    autoload :RedisSets, "friendship/storage/redis_sets"

  end

  def self.use(klass, connection)
    klass.connection = connection
    self.storage = klass
  end

  def self.friend(left, right)
    storage.friend(left, right)
  end

  def self.unfriend(left, right)
    storage.unfriend(left, right)
  end

  def self.friendships(left)
    storage.friendships(left)
  end

  def self.friend_of?(right, left)
    storage.friend_of?(right, left)
  end

  def self.mutual_friends(left, right)
    storage.mutual_friends(left, right)
  end

end

