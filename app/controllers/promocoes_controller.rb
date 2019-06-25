class PromocoesController < ApplicationController
  before_action :set_promocao, only: [:show, :edit, :update, :destroy]
  before_action :set_produto
  before_action :set_upsell

  # GET /promocoes
  # GET /promocoes.json
  def index
    @promocoes = Promocao.all
  end

  # GET /promocoes/1
  # GET /promocoes/1.json
  def show
  end

  # GET /promocoes/new
  def new
    @promocao = Promocao.new
  end

  # GET /promocoes/1/edit
  def edit
  end

  # POST /promocoes
  # POST /promocoes.json
  def create
    @promocao = Promocao.new(promocao_params)
    @promocao.upsell = @upsell

    respond_to do |format|
      if @promocao.save
        upsell_produto_save
        format.html { redirect_to edit_produto_upsell_promocao_path(@produto, @upsell, @promocao), notice: 'Promocao was successfully created.' }
        format.json { render :show, status: :created, location: @promocao }
      else
        format.html { render :new }
        format.json { render json: @promocao.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /promocoes/1
  # PATCH/PUT /promocoes/1.json
  def update
    respond_to do |format|
      if @promocao.update(promocao_params)
        upsell_produto_save
        format.html { redirect_to edit_produto_upsell_promocao_path(@produto, @upsell, @promocao), notice: 'Promocao was successfully updated.' }
        format.json { render :show, status: :ok, location: @promocao }
      else
        format.html { render :edit }
        format.json { render json: @promocao.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /promocoes/1
  # DELETE /promocoes/1.json
  def destroy
    @promocao.destroy
    respond_to do |format|
      format.html { redirect_to produto_upsell_promocoes_path(@produto, @upsell), notice: 'Promocao was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def upsell_produto_save
      if params[:item_promocao].present?
        @promocao.item_promocoes.destroy_all

        params[:item_promocao].each do |item_promocao|
          if item_promocao[:codigo_produto].present?
            ItemPromocao.create!(
              promocao_id: @promocao.id,
              codigo_produto: item_promocao[:codigo_produto],
              preco_promocional: item_promocao[:preco_promocional],
              quantidade: item_promocao[:quantidade],
              imagem: item_promocao[:imagem],
              se_pago_vai_para: item_promocao[:se_pago_vai_para],
              btn_negado: item_promocao[:btn_negado],
              btn_aceito: item_promocao[:btn_aceito],
              video: item_promocao[:video]
            )
          end
        end
      end
    end

    def set_produto
      @produto = Produto.find(params[:produto_id])
    end

    def set_upsell
      @upsell = Upsell.find(params[:upsell_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_promocao
      @promocao = Promocao.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def promocao_params
      params.require(:promocao).permit(:upsell_id, :nome, :tempo_relogio, :se_pago_vai_para, :se_negou_vai_para, :titulo, :subtitulo, :descricao, :conteudo)
    end
end
