class User < ActiveRecord::Base
  include ActiveRecord::Sharding::Model
  use_sharding :user, :modulo # shard name, algorithm
  define_sharding_key :id

  include ActiveRecord::Sharding::Sequencer
  use_sequencer :user

  before_put do |attributes|
    attributes[:id] = next_sequence_id unless attributes[:id]
  end
end
