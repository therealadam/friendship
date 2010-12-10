require "redis"

module Friendship::Storage::RedisSets

  mattr_accessor :connection

  def self.follow(follower, followee)
    connection.sadd(follower, followee)
  end

  def self.friendships(follower)
    connection.smembers(follower)
  end

  def self.friend_of?(followee, follower)
    connection.sismember(followee, follower)
  end

  def self.mutual_friends(left, right)
    connection.sinter(left, right)
  end

end
