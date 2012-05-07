class StatValuesController < ApplicationController
  include IsLoggedIn
  before_filter :is_superuser

  # GET /stat_values
  # GET /stat_values.json
  def index
    stat_values = StatValue.
      includes(:access_token, :strategy => [:mallet_run]).
      where('strategies.name IS NOT NULL').
      order( "mallet_runs.name, strategies.name, access_tokens.name")

    @grid = CollapsingGrid.new stat_values

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: stat_values }
    end
  end

  # GET /stat_values/1
  # GET /stat_values/1.json
  def show
    @stat_value = StatValue.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @stat_value }
    end
  end

  # GET /stat_values/new
  # GET /stat_values/new.json
  def new
    @stat_value = StatValue.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @stat_value }
    end
  end

  # GET /stat_values/1/edit
  def edit
    @stat_value = StatValue.find(params[:id])
  end

  # POST /stat_values
  # POST /stat_values.json
  def create
    @stat_value = StatValue.new(params[:stat_value])

    respond_to do |format|
      if @stat_value.save
        format.html { redirect_to @stat_value, notice: 'Stat value was successfully created.' }
        format.json { render json: @stat_value, status: :created, location: @stat_value }
      else
        format.html { render action: "new" }
        format.json { render json: @stat_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /stat_values/1
  # PUT /stat_values/1.json
  def update
    @stat_value = StatValue.find(params[:id])

    respond_to do |format|
      if @stat_value.update_attributes(params[:stat_value])
        format.html { redirect_to @stat_value, notice: 'Stat value was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @stat_value.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stat_values/1
  # DELETE /stat_values/1.json
  def destroy
    @stat_value = StatValue.find(params[:id])
    @stat_value.destroy

    respond_to do |format|
      format.html { redirect_to stat_values_url }
      format.json { head :no_content }
    end
  end
end
