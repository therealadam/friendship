# Friendship

## Protocol

follow(follower, followee)
unfollow(follower, followee)
friendships(follower)
mutual_friends(user, user)

## Adapters

- Cassandra
- Redis sets
- Redis lists
- Memcached
- PostgreSQL

## Investigate

- Grape-based API
- Request stages via EM
- Bloom-filter storage
