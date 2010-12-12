require "ffaker"
require "redis"
require "friendship"
require "benchmark"
require "yaml"
require "system_timer"

module FriendshipBenchmark
  USERLIST = "userlist.yml"

  def self.generate_userlist(length)
    users = length.times.map { Faker::Name.name }
    data = YAML.dump(users)
    File.open(USERLIST, "w") { |f| f.write(data) }
    users
  end

  def self.load_userlist
    data = File.read(USERLIST)
    YAML.load(data)
  end

  def self.random_user(users)
    users[rand(users.length)]
  end

  def self.populate(users, friends)
    result = Benchmark.measure do
      users.each do |u|
        friends.times { Friendship.friend(u, random_user(users)) }
      end
    end
  end

  def self.measure_friend_of(ops, users)
    ops.times do
      user = random_user(users)
      friend = random_user(users)
      Friendship.friend_of?(user, friend)
    end
  end

end

users_count = 100_000
friends = 50
ops = 100
iterations = 1000

engines = {
  "redis sets" => lambda { Friendship.use(Friendship::Storage::RedisSets, Redis.new(:db => 0)) },
  "redis lists" => lambda { Friendship.use(Friendship::Storage::RedisLists, Redis.new(:db => 1)) },
  "cassandra" => lambda { Friendship.use(Friendship::Storage::Cassandra, Cassandra.new("Friendship")) }
}

case ARGV[0]
when 'populate'
  users = FriendshipBenchmark.generate_userlist(users_count)
  puts "Populating #{users.length} users"
  Benchmark.bm do |b|
    engines.each do |name, connection|
      b.report(name) do
        connection.call
        FriendshipBenchmark.populate(users, friends)
      end
    end
  end
when 'benchmark'
  users = FriendshipBenchmark.load_userlist
  puts "#{users_count} users, #{friends} friends, #{ops} lookups, #{iterations} iterations"
  Benchmark.bmbm(25) do |b|
    users = FriendshipBenchmark.load_userlist
    engines.each do |name, connection|
      connection.call
      b.report(name) do
        iterations.times { FriendshipBenchmark.measure_friend_of(ops, users) }
      end
    end
  end
end

