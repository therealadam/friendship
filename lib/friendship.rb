require "active_support/core_ext/module"

module Friendship

  mattr_accessor :storage

  autoload :Storage, "friendship/storage"

  def self.use(klass, connection)
    klass.connection = connection
    self.storage = klass
  end

  def self.follow(follower, followee)
    storage.follow(follower, followee)
  end

  def self.friendships(follower)
    storage.friendships(follower)
  end

  def self.friend_of?(followee, follower)
    storage.friend_of?(followee, follower)
  end

  def self.mutual_friends(left, right)
    storage.mutual_friends(left, right)
  end

end

