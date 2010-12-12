require "cassandra"

module Friendship::Storage::Cassandra

  mattr_accessor :connection

  def self.friend(friender, friendee)
    connection.insert(:Friendships, friender, {friendee => ''})
  end

  def self.friendships(friender)
    connection.get(:Friendships, friender).keys
  end

  def self.friend_of?(friender, friendee)
    connection.exists?(:Friendships, friender, friendee)
  end

  def self.unfriend(friender, friendee)
    connection.remove(:Friendships, friender, friendee)
  end

  def self.mutual_friends(left, right)
    # TODO: extract this into a mixin
    left_friends = Set.new(friendships(left))
    right_friends = Set.new(friendships(right))
    left_friends.intersection(right_friends).to_a
  end

end
