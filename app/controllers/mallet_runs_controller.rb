class MalletRunsController < ApplicationController
  # GET /mallet_runs
  # GET /mallet_runs.json
  def index
    @mallet_runs = MalletRun.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mallet_runs }
    end
  end

  # GET /mallet_runs/1
  # GET /mallet_runs/1.json
  def show
    @mallet_run = MalletRun.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mallet_run }
    end
  end

  # GET /mallet_runs/new
  # GET /mallet_runs/new.json
  def new
    @mallet_run = MalletRun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mallet_run }
    end
  end

  # GET /mallet_runs/1/edit
  def edit
    @mallet_run = MalletRun.find(params[:id])
  end

  # POST /mallet_runs
  # POST /mallet_runs.json
  def create
    @mallet_run = MalletRun.new(params[:mallet_run])

    respond_to do |format|
      if @mallet_run.save
        format.html { redirect_to @mallet_run, notice: 'Mallet run was successfully created.' }
        format.json { render json: @mallet_run, status: :created, location: @mallet_run }
      else
        format.html { render action: "new" }
        format.json { render json: @mallet_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mallet_runs/1
  # PUT /mallet_runs/1.json
  def update
    @mallet_run = MalletRun.find(params[:id])

    respond_to do |format|
      if @mallet_run.update_attributes(params[:mallet_run])
        format.html { redirect_to @mallet_run, notice: 'Mallet run was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mallet_run.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mallet_runs/1
  # DELETE /mallet_runs/1.json
  def destroy
    @mallet_run = MalletRun.find(params[:id])
    @mallet_run.destroy

    respond_to do |format|
      format.html { redirect_to mallet_runs_url }
      format.json { head :no_content }
    end
  end
end
