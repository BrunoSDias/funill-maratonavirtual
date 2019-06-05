class UpsellController < ApplicationController
  before_action :set_upsell, only: [:show, :edit, :update, :destroy]
  before_action :set_produto

  # GET /upsell
  # GET /upsell.json
  def index
    @upsell = Upsell.where(produto_id: @produto.id)
  end

  # GET /upsell/1
  # GET /upsell/1.json
  def show
  end

  # GET /upsell/new
  def new
    @upsell = Upsell.new
  end

  # GET /upsell/1/edit
  def edit
  end

  # POST /upsell
  # POST /upsell.json
  def create
    @upsell = Upsell.new(upsell_params)
    @upsell.produto = @produto

    respond_to do |format|
      if @upsell.save
        format.html { redirect_to produto_upsell_index_path(@produto), notice: 'Upsell was successfully created.' }
        format.json { render :show, status: :created, location: @upsell }
      else
        format.html { render :new }
        format.json { render json: @upsell.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /upsell/1
  # PATCH/PUT /upsell/1.json
  def update
    respond_to do |format|
      if @upsell.update(upsell_params)
        format.html { redirect_to produto_upsell_index_path(@produto), notice: 'Upsell was successfully updated.' }
        format.json { render :show, status: :ok, location: @upsell }
      else
        format.html { render :edit }
        format.json { render json: @upsell.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /upsell/1
  # DELETE /upsell/1.json
  def destroy
    @upsell.destroy
    respond_to do |format|
      format.html { redirect_to produto_upsell_index_path(@produto), notice: 'Upsell was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_produto
      @produto = Produto.find(params[:produto_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_upsell
      @upsell = Upsell.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def upsell_params
      params.require(:upsell).permit(:produto_id, :data_inicial, :data_final, :somente_boleto, :somente_cartao, :tentar_a_cada_compra, :mostrar_para_compras_acima_de, :mostrar_para_compras_ate)
    end
end
