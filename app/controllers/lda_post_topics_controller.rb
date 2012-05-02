class LdaPostTopicsController < ApplicationController
  # GET /lda_post_topics
  # GET /lda_post_topics.json
  def index
    @lda_post_topics = LdaPostTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lda_post_topics }
    end
  end

  # GET /lda_post_topics/1
  # GET /lda_post_topics/1.json
  def show
    @lda_post_topic = LdaPostTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lda_post_topic }
    end
  end

  # GET /lda_post_topics/new
  # GET /lda_post_topics/new.json
  def new
    @lda_post_topic = LdaPostTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lda_post_topic }
    end
  end

  # GET /lda_post_topics/1/edit
  def edit
    @lda_post_topic = LdaPostTopic.find(params[:id])
  end

  # POST /lda_post_topics
  # POST /lda_post_topics.json
  def create
    @lda_post_topic = LdaPostTopic.new(params[:lda_post_topic])

    respond_to do |format|
      if @lda_post_topic.save
        format.html { redirect_to @lda_post_topic, notice: 'Lda post topic was successfully created.' }
        format.json { render json: @lda_post_topic, status: :created, location: @lda_post_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @lda_post_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lda_post_topics/1
  # PUT /lda_post_topics/1.json
  def update
    @lda_post_topic = LdaPostTopic.find(params[:id])

    respond_to do |format|
      if @lda_post_topic.update_attributes(params[:lda_post_topic])
        format.html { redirect_to @lda_post_topic, notice: 'Lda post topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lda_post_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lda_post_topics/1
  # DELETE /lda_post_topics/1.json
  def destroy
    @lda_post_topic = LdaPostTopic.find(params[:id])
    @lda_post_topic.destroy

    respond_to do |format|
      format.html { redirect_to lda_post_topics_url }
      format.json { head :no_content }
    end
  end
end
