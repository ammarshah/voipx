class BreakoutsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_breakout, only: [:show, :edit, :update, :destroy]

  # GET /breakouts
  # GET /breakouts.json
  def index
    @breakouts = Breakout.all
  end

  # GET /breakouts/1
  # GET /breakouts/1.json
  def show
  end

  # GET /breakouts/new
  def new
    @breakout = Breakout.new
  end

  # GET /breakouts/1/edit
  def edit
  end

  # POST /breakouts
  # POST /breakouts.json
  def create
    @breakout = Breakout.new(breakout_params)

    respond_to do |format|
      if @breakout.save
        format.html { redirect_to @breakout, notice: 'Breakout was successfully created.' }
        format.json { render :show, status: :created, location: @breakout }
      else
        format.html { render :new }
        format.json { render json: @breakout.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /breakouts/1
  # PATCH/PUT /breakouts/1.json
  def update
    respond_to do |format|
      if @breakout.update(breakout_params)
        format.html { redirect_to @breakout, notice: 'Breakout was successfully updated.' }
        format.json { render :show, status: :ok, location: @breakout }
      else
        format.html { render :edit }
        format.json { render json: @breakout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /breakouts/1
  # DELETE /breakouts/1.json
  def destroy
    @breakout.destroy
    respond_to do |format|
      format.html { redirect_to breakouts_url, notice: 'Breakout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_breakout
      @breakout = Breakout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def breakout_params
      params.require(:breakout).permit(:code, :destination, :parent_id)
    end
end
