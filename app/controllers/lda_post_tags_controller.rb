class LdaPostTagsController < ApplicationController

  include IsLoggedIn
  before_filter :is_superuser
  
  # GET /lda_post_tags
  # GET /lda_post_tags.json
  def index
    @lda_post_tags = LdaPostTag.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lda_post_tags }
    end
  end

  # GET /lda_post_tags/1
  # GET /lda_post_tags/1.json
  def show
    @lda_post_tag = LdaPostTag.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lda_post_tag }
    end
  end

  # GET /lda_post_tags/new
  # GET /lda_post_tags/new.json
  def new
    @lda_post_tag = LdaPostTag.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lda_post_tag }
    end
  end

  # GET /lda_post_tags/1/edit
  def edit
    @lda_post_tag = LdaPostTag.find(params[:id])
  end

  # POST /lda_post_tags
  # POST /lda_post_tags.json
  def create
    @lda_post_tag = LdaPostTag.new(params[:lda_post_tag])

    respond_to do |format|
      if @lda_post_tag.save
        format.html { redirect_to @lda_post_tag, notice: 'Lda post tag was successfully created.' }
        format.json { render json: @lda_post_tag, status: :created, location: @lda_post_tag }
      else
        format.html { render action: "new" }
        format.json { render json: @lda_post_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lda_post_tags/1
  # PUT /lda_post_tags/1.json
  def update
    @lda_post_tag = LdaPostTag.find(params[:id])

    respond_to do |format|
      if @lda_post_tag.update_attributes(params[:lda_post_tag])
        format.html { redirect_to @lda_post_tag, notice: 'Lda post tag was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lda_post_tag.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lda_post_tags/1
  # DELETE /lda_post_tags/1.json
  def destroy
    @lda_post_tag = LdaPostTag.find(params[:id])
    @lda_post_tag.destroy

    respond_to do |format|
      format.html { redirect_to lda_post_tags_url }
      format.json { head :no_content }
    end
  end
end
