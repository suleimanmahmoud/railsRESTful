class VoosController < ApplicationController
  before_action :set_voo, only: [:show, :edit, :update, :destroy]

  # GET /voos
  # GET /voos.json
  def index
    @voos = Voo.all
  end

  # GET /voos/1
  # GET /voos/1.json
  def show
  end

  # GET /voos/new
  def new
    @voo = Voo.new
  end

  # GET /voos/1/edit
  def edit
  end

  # POST /voos
  # POST /voos.json
  def create
    @voo = Voo.new(voo_params)

    respond_to do |format|
      if @voo.save
        format.html { redirect_to @voo, notice: 'Voo was successfully created.' }
        format.json { render :show, status: :created, location: @voo }
      else
        format.html { render :new }
        format.json { render json: @voo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /voos/1
  # PATCH/PUT /voos/1.json
  def update
    respond_to do |format|
      if @voo.update(voo_params)
        format.html { redirect_to @voo, notice: 'Voo was successfully updated.' }
        format.json { render :show, status: :ok, location: @voo }
      else
        format.html { render :edit }
        format.json { render json: @voo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /voos/1
  # DELETE /voos/1.json
  def destroy
    @voo.destroy
    respond_to do |format|
      format.html { redirect_to voos_url, notice: 'Voo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_voo
      @voo = Voo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def voo_params
      params.require(:voo).permit(:name, :tipo, :origem, :destino, :dataida, :datavolta, :price)
    end
end
