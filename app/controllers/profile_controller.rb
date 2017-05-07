class ProfileController < ApplicationController
  def show
  	@user = User.find_by_nick(params[:id])

  	if @user
  		@posts = @user.posts.all
  		render action: :show
  	else
  		render file: 'public/404', status: 404, formats: [:html]
  	end
  end
end
