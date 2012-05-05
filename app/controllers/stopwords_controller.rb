class StopwordsController < ApplicationController
  include IsLoggedIn
  before_filter :is_superuser

  # GET /stopwords
  # GET /stopwords.json
  def index
    @stopwords = Stopword.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stopwords }
    end
  end

  # GET /stopwords/1
  # GET /stopwords/1.json
  def show
    @stopword = Stopword.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stopword }
    end
  end

  # GET /stopwords/new
  # GET /stopwords/new.json
  def new
    @stopword = Stopword.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stopword }
    end
  end

  # GET /stopwords/1/edit
  def edit
    @stopword = Stopword.find(params[:id])
  end

  # POST /stopwords
  # POST /stopwords.json
  def create
    @stopword = Stopword.new(params[:stopword])

    respond_to do |format|
      if @stopword.save
        format.html { redirect_to @stopword, notice: 'Stopword was successfully created.' }
        format.json { render json: @stopword, status: :created, location: @stopword }
      else
        format.html { render action: "new" }
        format.json { render json: @stopword.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stopwords/1
  # PUT /stopwords/1.json
  def update
    @stopword = Stopword.find(params[:id])

    respond_to do |format|
      if @stopword.update_attributes(params[:stopword])
        format.html { redirect_to @stopword, notice: 'Stopword was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stopword.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stopwords/1
  # DELETE /stopwords/1.json
  def destroy
    @stopword = Stopword.find(params[:id])
    @stopword.destroy

    respond_to do |format|
      format.html { redirect_to stopwords_url }
      format.json { head :no_content }
    end
  end
end
