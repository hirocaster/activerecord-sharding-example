# ActiveRecord::Sharding Rails example app

## How to boot app on docker

1. Build containers.

``` shell
$ ./build.sh
```

2. Run containers.

``` shell
$ ./run.sh
```

4. Access containers.

Wait about 10second. Rails bootup migrations. Go to `http://localhost:3000`

You can try web console.

example codes

``` ruby
User.put!(name: "foo") # create new user.

User.shard_for(0).all # User.all for user-0 host
User.shard_for(1).all # User.all for user-1 host

User.all_shards.flat_map { |model| model.all }.compact # User.all for all shards

User.parallel.flat_map { |model| model.all }.compact # Parallel User.all for all shards
```

3. Stop containers

``` shell
$ ./stop.sh
```
