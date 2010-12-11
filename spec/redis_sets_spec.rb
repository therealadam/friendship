require "spec_helper"

describe Friendship::Storage::RedisSets do

  # TODO: don't test against a running Redis instance?
  before do
    redis = Redis.new(:db => "friendship-test")
    redis.flushdb
    Friendship::Storage::RedisSets.connection = redis
  end

  it_behaves_like "friendship storage"

end

