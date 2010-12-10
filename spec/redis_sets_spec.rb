require "spec_helper"

describe Friendship::Storage::RedisSets do

  # TODO: don't test against a running Redis instance?
  before do
    redis = Redis.new(:db => "friendship-test")
    redis.flushdb
    Friendship::Storage::RedisSets.connection = redis
  end

  it "creates and fetches relationships" do
    subject.follow("john", "paul")
    subject.follow("john", "george")
    subject.follow("john", "ringo")

    subject.friendships("john").should == %w{ringo george paul}
  end

  it "checks if one user is friends with another" do
    subject.follow("john", "paul")
    subject.follow("paul", "john")
    
    subject.friend_of?("john", "paul").should be_true
  end

  it "finds mutual friends" do
    subject.follow("john", "george")
    subject.follow("john", "ringo")
    subject.follow("paul", "george")
    subject.follow("paul", "ringo")

    subject.mutual_friends("john", "paul").should == ["ringo", "george"]
  end

end

