class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    respond_to do |format|
      format.html #index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post_attachments = @post.post_attachments.all
  end

  # GET /posts/new
  def new
    @post = Post.new
    @post_attachment = @post.post_attachments.build
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
    if @post.user.nick != current_user.nick and !current_user.has_role? :admin
      redirect_to timeline_path, :alert => "You cannot edit another user’s post!"
    else
      @post = Post.find(params[:id])
    end
  end

  # POST /posts
  # POST /posts.json



  def create
    if !user_signed_in?
      redirect_to login_path, :alert => "You need to sign in or sign up before continuing."
    else
      @post = Post.new(post_params)
      @post.user = current_user
      respond_to do |format|
        if @post.save
          notifyTagUsers(@post)

          if params.has_key?(:post_attachments)
            params[:post_attachments]['avatar'].each do |a|
              @post_attachment = @post.post_attachments.create!(:avatar => a)
            end
          end

          format.html { redirect_to timeline_path, notice: 'Post was successfully created.' }
          format.json { render :show, status: :created, location: @post }
        else
          format.html { render action: 'new' }
          format.json { render json: @post.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  #def create
    #@post = Post.new(post_params)

    #respond_to do |format|
      #if @post.save
        #format.html { redirect_to @post, notice: 'Post was successfully created.' }
        #format.json { render :show, status: :created, location: @post }
      #else
        #format.html { render :new }
        #format.json { render json: @post.errors, status: :unprocessable_entity }
      #end
    #end
  #end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)

        #format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.html { redirect_to timeline_path, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    if @post.user.nick != current_user.nick  and !current_user.has_role? :admin
      redirect_to timeline_path, :alert => "You can't delete another user’s post!"
    else
      @post.destroy
      respond_to do |format|
        format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
        format.json { head :no_content }
      end
    end
  end

  def likePost
    @post = Post.find(params[:post])
    @post.liked_by current_user
    redirect_to timeline_path, :notice => "You like this post: " + @post.contenido
  end

  def dislikePost
    @post = Post.find(params[:post])
    @post.disliked_by current_user
    redirect_to timeline_path, :notice => "You don't like this post: " + @post.contenido
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:user_id, :contenido,  post_attachments_attributes: [:id, :post_id, :avatar])
    end

    def notifyTagUsers(post)
      values = post.contenido.split(" ")

      # Display each value to the console.
      values.each do |value|
        if value[0] == '@' 
          value1 = value[1..-1]
          u = User.find_by_nick(value1)

          if u and current_user.friends_with?(u)
            Notification.create(user_id: u.id,
                        notified_by_id: current_user.id,
                        post_id: post.id,
                        type_notification: 'postTag')
          end
        end
      end
    end
end
