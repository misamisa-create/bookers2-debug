class RelationshipsController < ApplicationController

  def create
    @user=User.find(params[:followed_id])
    following=current_user.follow(@user)
    following.save
    redirect_back(fallback_location:root_path)
  end

  def destroy
    @user=User.find(params[:followed_id])
    following=current_user.unfollow(@user)
    following.destroy
    redirect_back(fallback_location:root_path)
  end

  def followings
    @user=User.find(params[:id])
    @users=@user.followings
  end

  def followers
    @user=User.find(params[:id])
    @users=@user.followers
  end

end
