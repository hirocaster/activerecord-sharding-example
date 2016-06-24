class UsersController < ApplicationController
  def index
    @seq = User.current_sequence_id
    @users_b = User.shard_for(0).all
    @users_c = User.shard_for(1).all
    console
  end
end
