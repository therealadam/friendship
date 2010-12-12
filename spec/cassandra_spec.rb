require "spec_helper"

describe Friendship::Storage::Cassandra do

  before do
    cassandra = Cassandra.new("Friendship")
    cassandra.clear_keyspace!
    Friendship::Storage::Cassandra.connection = cassandra
  end

  it_behaves_like "friendship storage"

end
