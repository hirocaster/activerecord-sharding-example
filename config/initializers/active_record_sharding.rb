ActiveRecord::Sharding.configure do |config|
  config.define_sequencer(:user) do |sequencer|
    sequencer.register_connection(:user_sequencer)
    sequencer.register_table_name('user_id')
  end

  config.define_cluster(:user) do |cluster|
    cluster.register_connection(:user_0)
    cluster.register_connection(:user_1)
  end
end
