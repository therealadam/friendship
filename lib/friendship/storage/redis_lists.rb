require "redis"
require "set"

module Friendship::Storage::RedisLists

  mattr_accessor :connection

  def self.friend(friender, friendee)
    connection.lpush(friender, friendee)
  end

  def self.friendships(user)
    connection.lrange(user, 0, -1)
  end

  def self.friend_of?(friender, friendee)
    Set.new(friendships(friender)).include?(friendee)
  end

  def self.unfriend(friender, friendee)
    connection.lrem(friender, 0, friendee)
  end

  def self.mutual_friends(left, right)
    left_friends = Set.new(friendships(left))
    right_friends = Set.new(friendships(right))
    left_friends.intersection(right_friends).to_a
  end

end
