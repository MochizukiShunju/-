class RelationshipsController < ApplicationController

  def follower
    @user = User.find(params[:id])
    @followers = @user.following_user.where.not(id: @user.id)
  end

  def followed
    @user = User.find(params[:id])
    @followed = @user.follower_user.where.not(id: @user.id)
  end

  def create
    @user = current_user.follow(params[:user_id])
    redirect_back(fallback_location: root_path)
  end

  def destroy
    @user = current_user.unfollow(params[:id])
    redirect_back(fallback_location: root_path)
  end

end