class InteractionsController < ApplicationController
	def show
  		if user_signed_in?
  			render action: :show
  		end
    end

    def markNotificationRead
    	@notificacion = Notification.find(params[:n])
    	@notification.read = true
    	redirect_to timeline_path
  	end
end
