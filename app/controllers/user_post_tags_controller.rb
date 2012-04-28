class UserPostTagsController < ApplicationController
  include IsLoggedIn
  
  # GET /user_post_tags
  # GET /user_post_tags.json
  def index
    @user_post_tags = UserPostTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_post_tags }
    end
  end

  # GET /user_post_tags/1
  # GET /user_post_tags/1.json
  def show
    @user_post_tag = UserPostTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_post_tag }
    end
  end

  # GET /user_post_tags/new
  # GET /user_post_tags/new.json
  def new
    @user_post_tag = UserPostTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_post_tag }
    end
  end

  # GET /user_post_tags/1/edit
  def edit
    @user_post_tag = UserPostTag.find(params[:id])
  end

  # POST /user_post_tags
  # POST /user_post_tags.json
  def create
    @user_post_tag = UserPostTag.new(params[:user_post_tag])

    respond_to do |format|
      if @user_post_tag.save
        format.html { redirect_to @user_post_tag, notice: 'User post tag was successfully created.' }
        format.json { render json: @user_post_tag, status: :created, location: @user_post_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @user_post_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_post_tags/1
  # PUT /user_post_tags/1.json
  def update
    @user_post_tags = UserPostTag.includes(:post)
      .where( :access_token_id => @user.id, :tag => params[:id],
              :posts => { :dataset_id => params[:dataset]})
    @user_post_tags.each do |tag|
      tag.tag = params[:tag]
      tag.save!
    end

    while (posts = UserPostTag.includes(:post).
        where( :access_token_id => @user.id, :posts => { :dataset_id => params[:dataset]}).
        group("post_id, tag").having( "count(*) > 1").all).size > 0
      posts.each do |post|
        post.destroy
      end
    end

    respond_to do |format|
      tags = UserPostTag.user( @user).dataset( params[:dataset]).count(:group => 'user_post_tags.tag')
      format.json { render :json => tags }
    end
  end

  # DELETE /user_post_tags/1
  # DELETE /user_post_tags/1.json
  def destroy
    user_post_tags = UserPostTag.includes(:post)
      .where( :access_token_id => @user.id, :tag => params[:id],
              :posts => {:dataset_id => params[:dataset]})
    user_post_tags.each do |tag|
      tag.destroy
    end

    respond_to do |format|
      format.json { head :no_content }
    end
  end
end
