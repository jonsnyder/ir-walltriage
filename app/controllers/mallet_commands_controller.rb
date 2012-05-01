class MalletCommandsController < ApplicationController
  # GET /mallet_commands
  # GET /mallet_commands.json
  def index
    @mallet_commands = MalletCommand.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mallet_commands }
    end
  end

  # GET /mallet_commands/1
  # GET /mallet_commands/1.json
  def show
    @mallet_command = MalletCommand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mallet_command }
    end
  end

  # GET /mallet_commands/new
  # GET /mallet_commands/new.json
  def new
    @mallet_command = MalletCommand.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mallet_command }
    end
  end

  # GET /mallet_commands/1/edit
  def edit
    @mallet_command = MalletCommand.find(params[:id])
  end

  # POST /mallet_commands
  # POST /mallet_commands.json
  def create
    @mallet_command = MalletCommand.new(params[:mallet_command])

    respond_to do |format|
      if @mallet_command.save
        format.html { redirect_to @mallet_command, notice: 'Mallet command was successfully created.' }
        format.json { render json: @mallet_command, status: :created, location: @mallet_command }
      else
        format.html { render action: "new" }
        format.json { render json: @mallet_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mallet_commands/1
  # PUT /mallet_commands/1.json
  def update
    @mallet_command = MalletCommand.find(params[:id])

    respond_to do |format|
      if @mallet_command.update_attributes(params[:mallet_command])
        format.html { redirect_to @mallet_command, notice: 'Mallet command was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @mallet_command.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mallet_commands/1
  # DELETE /mallet_commands/1.json
  def destroy
    @mallet_command = MalletCommand.find(params[:id])
    @mallet_command.destroy

    respond_to do |format|
      format.html { redirect_to mallet_commands_url }
      format.json { head :no_content }
    end
  end
end
