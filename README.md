# Friendship

This is an experiment in using various databases to store social graph
information and perform common operations on that data. I'm mostly interested
in tinkering around with various databases, data structures, and service
interfaces.

This idea is rated _not-production-ready_, and _experimental_.

Take a look in `examples` for a benchmark and a use-case. Don't say I never did
anything for you.

## Protocol

friend(user, user)
unfriend(user, user)
friendships(user)
mutual_friends(user, user)
friend_of?(user, user)

## Storage

Today:

- Cassandra
- Redis sets
- Redis lists

Someday, maybe:

- Memcached
- PostgreSQL
- Riak
- In-memory

## Investigate

- Grape-based API
- Request stages via EM
- Bloom-filter storage
- Memcached protocol 
- An Ernie service
