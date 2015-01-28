class VoosController < ApplicationController
  before_action :set_voo, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  respond_to :html, :xml, :json

  # GET /voos
  # GET /voos.json
  def index
    if params[:fromcidade].present? and params[:tocidade].present? and params[:fromdate].present? and params[:todate].present?
      @voos = Voo.search params[:fromcidade] + ' ' + params[:tocidade], 
        operator: "or",
        order: {price: :desc}, 
        fields: [{origem: :word},{destino: :word}],
        where: {
          dataida: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          },
          datavolta:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:fromcidade].present? and params[:fromdate].present? and params[:todate].present?
      @voos = Voo.search params[:fromcidade],
        order: {price: :desc}, 
        fields: [{origem: :word}],
        where: {
          dataida: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          },
          datavolta:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:tocidade].present? and params[:fromdate].present? and params[:todate].present?
      @voos = Voo.search params[:fromcidade],
        order: {price: :desc}, 
        fields: [{destino: :word}],
        where: {
          dataida: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          },
          datavolta:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:fromcidade].present? and params[:fromdate].present?
      @voos = Voo.search params[:fromcidade],
        order: {price: :desc}, 
        fields: [{origem: :word}],
        where: {
          dataida: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          }
        }
    elsif params[:fromcidade].present? and params[:todate].present?
      @voos = Voo.search params[:fromcidade],
        order: {price: :desc}, 
        fields: [{origem: :word}],
        where: {
          datavolta:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:fromcidade].present?
      @voos = Voo.search params[:fromcidade],
        order: {price: :desc}, 
        fields: [{origem: :word}]
    elsif params[:tocidade].present?
      @voos = Voo.search params[:tocidade],
        order: {price: :desc}, 
        fields: [{destino: :word}]
    else
      @voos = Voo.all.order('created_at DESC')
    end
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
    unless params[:price].to_s.present? #params[:price].to_s.blank?
      dateIda = DateTime.new(params["voo"]["dataida(1i)"].to_i,
                                      params["voo"]["dataida(2i)"].to_i,
                                      params["voo"]["dataida(3i)"].to_i)
      #minutes in a day = 1440 
      #seconds in a day = 86400
      #price = exp(1/numDias)*1500
      @voo.price = Math.exp(1/((dateIda.to_time - Time.now)/86400))*1500
    end
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
