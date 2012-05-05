class StopwordListsController < ApplicationController
  include IsLoggedIn
  before_filter :is_superuser

  
  # GET /stopword_lists
  # GET /stopword_lists.json
  def index
    @stopword_lists = StopwordList.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stopword_lists }
    end
  end

  # GET /stopword_lists/1
  # GET /stopword_lists/1.json
  def show
    @stopword_list = StopwordList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stopword_list }
    end
  end

  # GET /stopword_lists/new
  # GET /stopword_lists/new.json
  def new
    @stopword_list = StopwordList.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stopword_list }
    end
  end

  # GET /stopword_lists/1/edit
  def edit
    @stopword_list = StopwordList.find(params[:id])
  end

  # POST /stopword_lists
  # POST /stopword_lists.json
  def create
    @stopword_list = StopwordList.new(params[:stopword_list])

    respond_to do |format|
      if @stopword_list.save
        format.html { redirect_to @stopword_list, notice: 'Stopword list was successfully created.' }
        format.json { render json: @stopword_list, status: :created, location: @stopword_list }
      else
        format.html { render action: "new" }
        format.json { render json: @stopword_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stopword_lists/1
  # PUT /stopword_lists/1.json
  def update
    @stopword_list = StopwordList.find(params[:id])

    respond_to do |format|
      if @stopword_list.update_attributes(params[:stopword_list])
        format.html { redirect_to @stopword_list, notice: 'Stopword list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stopword_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stopword_lists/1
  # DELETE /stopword_lists/1.json
  def destroy
    @stopword_list = StopwordList.find(params[:id])
    @stopword_list.destroy

    respond_to do |format|
      format.html { redirect_to stopword_lists_url }
      format.json { head :no_content }
    end
  end
end
