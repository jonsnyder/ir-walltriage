class StrategiesController < ApplicationController
  # GET /strategies
  # GET /strategies.json
  def index
    @strategies = Strategy.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @strategies }
    end
  end

  # GET /strategies/1
  # GET /strategies/1.json
  def show
    @strategy = Strategy.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @strategy }
    end
  end

  # GET /strategies/new
  # GET /strategies/new.json
  def new
    @strategy = Strategy.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @strategy }
    end
  end

  # GET /strategies/1/edit
  def edit
    @strategy = Strategy.find(params[:id])
  end

  # POST /strategies
  # POST /strategies.json
  def create
    @strategy = Strategy.new(params[:strategy])

    respond_to do |format|
      if @strategy.save
        format.html { redirect_to @strategy, notice: 'Strategy was successfully created.' }
        format.json { render json: @strategy, status: :created, location: @strategy }
      else
        format.html { render action: "new" }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /strategies/1
  # PUT /strategies/1.json
  def update
    @strategy = Strategy.find(params[:id])

    respond_to do |format|
      if @strategy.update_attributes(params[:strategy])
        format.html { redirect_to @strategy, notice: 'Strategy was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @strategy.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /strategies/1
  # DELETE /strategies/1.json
  def destroy
    @strategy = Strategy.find(params[:id])
    @strategy.destroy

    respond_to do |format|
      format.html { redirect_to strategies_url }
      format.json { head :no_content }
    end
  end
end
