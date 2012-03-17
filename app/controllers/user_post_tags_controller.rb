class UserPostTagsController < ApplicationController
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
    @user_post_tag = UserPostTag.find(params[:id])

    respond_to do |format|
      if @user_post_tag.update_attributes(params[:user_post_tag])
        format.html { redirect_to @user_post_tag, notice: 'User post tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_post_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_post_tags/1
  # DELETE /user_post_tags/1.json
  def destroy
    @user_post_tag = UserPostTag.find(params[:id])
    @user_post_tag.destroy

    respond_to do |format|
      format.html { redirect_to user_post_tags_url }
      format.json { head :no_content }
    end
  end
end
