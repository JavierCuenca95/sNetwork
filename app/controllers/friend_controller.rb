class FriendController < ApplicationController
  def show
  	if user_signed_in?
  		render action: :show
  	else
  		#render file: 'public/404', status: 404, formats: [:html]
  		redirect_to timeline_path, :alert => "You cannot edit another user’s post!"
  	end
  end
end
