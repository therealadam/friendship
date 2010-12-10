require "ffaker"
require "redis"
require "friendship"
require "benchmark"

def random_user
  $users[rand($users.length)]
end

$users = 100_000.times.map { Faker::Name.name }
friends = 50
ops = 100

redis = Redis.new(:db => "friendship-benchmark")
Friendship.use(Friendship::Storage::RedisSets, redis)

if ENV['POPULATE']
  result = Benchmark.measure do
    redis.flushdb
    puts "Populating with #{$users.length} users"
    $users.each do |u|
      friends.times { Friendship.follow(u, random_user) }
    end
  end
  puts "Populating #{$users.length} users took #{result.real}s (#{result.utime} user)"
end

result = Benchmark.measure do
  ops.times do
    user = random_user
    friend = random_user
    Friendship.friend_of?(user, friend)
  end
end

puts "#{$users.length} users, #{friends} friends, #{ops} lookups, #{result.real}s (#{result.utime} user)"
