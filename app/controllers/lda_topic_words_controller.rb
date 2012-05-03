class LdaTopicWordsController < ApplicationController

  include IsLoggedIn
  before_filter :is_superuser

  # GET /lda_topic_words
  # GET /lda_topic_words.json
  def index
    @lda_topic_words = LdaTopicWord.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lda_topic_words }
    end
  end

  # GET /lda_topic_words/1
  # GET /lda_topic_words/1.json
  def show
    @lda_topic_word = LdaTopicWord.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lda_topic_word }
    end
  end

  # GET /lda_topic_words/new
  # GET /lda_topic_words/new.json
  def new
    @lda_topic_word = LdaTopicWord.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lda_topic_word }
    end
  end

  # GET /lda_topic_words/1/edit
  def edit
    @lda_topic_word = LdaTopicWord.find(params[:id])
  end

  # POST /lda_topic_words
  # POST /lda_topic_words.json
  def create
    @lda_topic_word = LdaTopicWord.new(params[:lda_topic_word])

    respond_to do |format|
      if @lda_topic_word.save
        format.html { redirect_to @lda_topic_word, notice: 'Lda topic word was successfully created.' }
        format.json { render json: @lda_topic_word, status: :created, location: @lda_topic_word }
      else
        format.html { render action: "new" }
        format.json { render json: @lda_topic_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lda_topic_words/1
  # PUT /lda_topic_words/1.json
  def update
    @lda_topic_word = LdaTopicWord.find(params[:id])

    respond_to do |format|
      if @lda_topic_word.update_attributes(params[:lda_topic_word])
        format.html { redirect_to @lda_topic_word, notice: 'Lda topic word was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lda_topic_word.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lda_topic_words/1
  # DELETE /lda_topic_words/1.json
  def destroy
    @lda_topic_word = LdaTopicWord.find(params[:id])
    @lda_topic_word.destroy

    respond_to do |format|
      format.html { redirect_to lda_topic_words_url }
      format.json { head :no_content }
    end
  end
end
