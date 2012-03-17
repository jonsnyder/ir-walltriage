class UserCommentTagsController < ApplicationController
  # GET /user_comment_tags
  # GET /user_comment_tags.json
  def index
    @user_comment_tags = UserCommentTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @user_comment_tags }
    end
  end

  # GET /user_comment_tags/1
  # GET /user_comment_tags/1.json
  def show
    @user_comment_tag = UserCommentTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user_comment_tag }
    end
  end

  # GET /user_comment_tags/new
  # GET /user_comment_tags/new.json
  def new
    @user_comment_tag = UserCommentTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user_comment_tag }
    end
  end

  # GET /user_comment_tags/1/edit
  def edit
    @user_comment_tag = UserCommentTag.find(params[:id])
  end

  # POST /user_comment_tags
  # POST /user_comment_tags.json
  def create
    @user_comment_tag = UserCommentTag.new(params[:user_comment_tag])

    respond_to do |format|
      if @user_comment_tag.save
        format.html { redirect_to @user_comment_tag, notice: 'User comment tag was successfully created.' }
        format.json { render json: @user_comment_tag, status: :created, location: @user_comment_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @user_comment_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /user_comment_tags/1
  # PUT /user_comment_tags/1.json
  def update
    @user_comment_tag = UserCommentTag.find(params[:id])

    respond_to do |format|
      if @user_comment_tag.update_attributes(params[:user_comment_tag])
        format.html { redirect_to @user_comment_tag, notice: 'User comment tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user_comment_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_comment_tags/1
  # DELETE /user_comment_tags/1.json
  def destroy
    @user_comment_tag = UserCommentTag.find(params[:id])
    @user_comment_tag.destroy

    respond_to do |format|
      format.html { redirect_to user_comment_tags_url }
      format.json { head :no_content }
    end
  end
end
