class LdaTopicsController < ApplicationController
  # GET /lda_topics
  # GET /lda_topics.json
  def index
    @lda_topics = LdaTopic.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lda_topics }
    end
  end

  # GET /lda_topics/1
  # GET /lda_topics/1.json
  def show
    @lda_topic = LdaTopic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lda_topic }
    end
  end

  # GET /lda_topics/new
  # GET /lda_topics/new.json
  def new
    @lda_topic = LdaTopic.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lda_topic }
    end
  end

  # GET /lda_topics/1/edit
  def edit
    @lda_topic = LdaTopic.find(params[:id])
  end

  # POST /lda_topics
  # POST /lda_topics.json
  def create
    @lda_topic = LdaTopic.new(params[:lda_topic])

    respond_to do |format|
      if @lda_topic.save
        format.html { redirect_to @lda_topic, notice: 'Lda topic was successfully created.' }
        format.json { render json: @lda_topic, status: :created, location: @lda_topic }
      else
        format.html { render action: "new" }
        format.json { render json: @lda_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lda_topics/1
  # PUT /lda_topics/1.json
  def update
    @lda_topic = LdaTopic.find(params[:id])

    respond_to do |format|
      if @lda_topic.update_attributes(params[:lda_topic])
        format.html { redirect_to @lda_topic, notice: 'Lda topic was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lda_topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lda_topics/1
  # DELETE /lda_topics/1.json
  def destroy
    @lda_topic = LdaTopic.find(params[:id])
    @lda_topic.destroy

    respond_to do |format|
      format.html { redirect_to lda_topics_url }
      format.json { head :no_content }
    end
  end
end
