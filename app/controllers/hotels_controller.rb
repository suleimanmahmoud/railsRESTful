class HotelsController < ApplicationController
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  respond_to :html, :xml, :json
  # GET /hotels
  # GET /hotels.json
  def index
    #@hotels = Hotel.all
    if params[:query].present? and params[:fromdate].present? and params[:todate].present?
      @hotels = Hotel.search params[:query],
        order: {price: :desc}, 
        fields: [{name: :word_start}],
        where: {
          dataentrada: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          },
          datasaida:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:query].present? and params[:fromdate].present?
      @hotels = Hotel.search params[:query],
        order: {price: :desc}, 
        fields: [{name: :word_start}],
        where: {
          dataentrada: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          }
        }
    elsif params[:query].present? and params[:todate].present?
      @hotels = Hotel.search params[:query],
        order: {price: :desc}, 
        fields: [{name: :word_start}],
        where: {
          datasaida:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:query].present?
      @hotels = Hotel.search params[:query],
        order: {price: :desc}, 
        fields: [{name: :word_start}]
    else
      @hotels = Hotel.all.order('created_at DESC')
    end
  end

  # GET /hotels/1
  # GET /hotels/1.json
  def show
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)
    unless params[:price].to_s.present? #params[:price].to_s.blank?
      dateVolta = DateTime.new(params["hotel"]["datasaida(1i)"].to_i,# the year
                                      params["hotel"]["datasaida(2i)"].to_i,# the month
                                      params["hotel"]["datasaida(3i)"].to_i)# the day
      print "Date volta to time = " + dateVolta.to_time.to_s
      dateIda = DateTime.new(params["hotel"]["dataentrada(1i)"].to_i,
                                      params["hotel"]["dataentrada(2i)"].to_i,
                                      params["hotel"]["dataentrada(3i)"].to_i)
      print "Date ida to time = " + dateIda.to_time.to_s
      #minutes in a day = 1440 
      #seconds in a day = 86400
      #price = vai ser 300 reais por dia 
      @hotel.price = (dateVolta.to_time - dateIda.to_time)/86400*300
    end
    respond_to do |format|
      if @hotel.save
        format.html { redirect_to @hotel, notice: 'Hotel was successfully created.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Hotel was successfully updated.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Hotel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :numeroquartos, :numeropessoas, :destino, :dataentrada, :datasaida, :price)
    end
end
