require "redis"

module Friendship::Storage::RedisSets

  mattr_accessor :connection

  def self.friend(left, right)
    connection.sadd(left, right)
  end

  def self.unfriend(left, right)
    connection.srem(left, right)
  end

  def self.friendships(left)
    connection.smembers(left)
  end

  def self.friend_of?(right, left)
    connection.sismember(right, left)
  end

  def self.mutual_friends(left, right)
    connection.sinter(left, right)
  end

end
