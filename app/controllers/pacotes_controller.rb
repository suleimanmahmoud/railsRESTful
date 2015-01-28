class PacotesController < ApplicationController
  before_action :set_pacote, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token
  respond_to :html, :xml, :json
  # GET /pacotes
  # GET /pacotes.json
  def index
    @pacotes = Pacote.all
    #if params[:search]
     # @pacotes = Pacote.search(params[:search]).order("created_at DESC")
    #else
    #  @pacotes = Pacote.all.order('created_at DESC')
    #end 
    if params[:query].present? and params[:fromdate].present? and params[:todate].present?
      @pacotes = Pacote.search params[:query],
        order: {price: :desc}, 
        fields: [{description: :word}],
        where: {
          dataida: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          },
          datavolta:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:query].present? and params[:fromdate].present?
      @pacotes = Pacote.search params[:query],
        order: {price: :desc}, 
        fields: [{description: :word}],
        where: {
          dataida: {
            gte: DateTime.strptime(params[:fromdate], '%d/%m/%Y')
          }
        }
    elsif params[:query].present? and params[:todate].present?
      @pacotes = Pacote.search params[:query],
        order: {price: :desc}, 
        fields: [{description: :word}],
        where: {
          datavolta:{
            lte: DateTime.strptime(params[:todate], '%d/%m/%Y')
          }
        }
    elsif params[:query].present?
      @pacotes = Pacote.search params[:query],
        order: {price: :desc}, 
        fields: [{description: :word}]
    else
      @pacotes = Pacote.all.order('created_at DESC')
    end
  end

  # GET /pacotes/1
  # GET /pacotes/1.json
  def show
    respond_to do |format|
      format.html { render :show }
      format.json { render json: @pacote}
    end
  end

  # GET /pacotes/new
  def new
    @pacote = Pacote.new
  end

  # GET /pacotes/1/edit
  def edit
  end

  # POST /pacotes
  # POST /pacotes.json
  def create
    @pacote = Pacote.new(pacote_params)
    #Pacote.reindex
<<-DOC 
a
DOC
    unless params[:price].to_s.present? #params[:price].to_s.blank?
      dateVolta = DateTime.new(params["pacote"]["datavolta(1i)"].to_i,# the year
                                      params["pacote"]["datavolta(2i)"].to_i,# the month
                                      params["pacote"]["datavolta(3i)"].to_i)# the day
      print "Date volta to time = " + dateVolta.to_time.to_s
      dateIda = DateTime.new(params["pacote"]["dataida(1i)"].to_i,
                                      params["pacote"]["dataida(2i)"].to_i,
                                      params["pacote"]["dataida(3i)"].to_i)
      print "Date ida to time = " + dateIda.to_time.to_s
      #minutes in a day = 1440 
      #seconds in a day = 86400
      #price = vai ser 150 reais por dia 
      @pacote.price = (dateVolta.to_time - dateIda.to_time)/86400*250
    end


    respond_to do |format|
      if @pacote.save
        format.html { redirect_to @pacote, notice: 'Pacote was successfully created.' }
        format.json { render :show, status: :created, location: @pacote }
      else
        format.html { render :new }
        format.json { render json: @pacote.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /pacotes/1
  # PATCH/PUT /pacotes/1.json
  def update
    respond_to do |format|
      if @pacote.update(pacote_params)
        format.html { redirect_to @pacote, notice: 'Pacote was successfully updated.' }
        format.json { render :show, status: :ok, location: @pacote }
      else
        format.html { render :edit }
        format.json { render json: @pacote.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /pacotes/1
  # DELETE /pacotes/1.json
  def destroy
    @pacote.destroy
    respond_to do |format|
      format.html { redirect_to pacotes_url, notice: 'Pacote was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_pacote
      @pacote = Pacote.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pacote_params
      params.require(:pacote).permit(:name, :description, :origem, :destino, :dataida, :datavolta, :price)
    end
end
