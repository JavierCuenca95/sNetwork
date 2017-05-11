class Users::RegistrationsController < Devise::RegistrationsController
  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  #def destroy
    #@posts = current_user.posts.all
    #@posts.each do |post|
      #puts post.contenido
      #post.delete
    #end
    #super
  #end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  def cancel
    #@posts = current_user.posts.all
    #@posts.each do |post|
      #puts post.contenido
      #post.delete
    #end
    super
  end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  #FRIENDSHIPS
  def sendRequest
    @user = User.find(params[:user])
    current_user.friend_request(@user)
    redirect_to timeline_path, :notice => "You have sent a friendship request to " + @user.nick
  end

  def acceptRequest
    @user = User.find(params[:user])
    current_user.accept_request(@user)
    #Notification.create(user_id: @user.id,
                        #notified_by_id: current_user.id,
                        #type_notification: 'friendRequestAccepted')

    n = Notification.new

    n.user_id = @user.id
    n.notified_by_id = current_user.id
    n.type_notification = 'friendRequestAccepted'
    n.save
    redirect_to timeline_path, :notice => "Now " + @user.nick + " and you are friends!"
  end

  def declineRequest
    @user = User.find(params[:user])
    current_user.decline_request(@user)
    redirect_to timeline_path, :notice => "You have declined the friendship request of " + @user.nick
  end

  def removeFriend
    @user = User.find(params[:user])
    current_user.remove_friend(@user)
    redirect_to timeline_path, :notice => "You have removed the friendship with " + @user.nick
  end
end
