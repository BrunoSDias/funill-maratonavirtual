class PaginasController < ApplicationController
  before_action :set_pagina, only: [:show, :edit, :update, :destroy]
  before_action :set_produto

  # GET /paginas
  # GET /paginas.json
  def index
    @paginas = Pagina.iniciais(@produto.id)
  end

  # GET /paginas/1
  # GET /paginas/1.json
  def show
  end

  # GET /paginas/new
  def new
    @pagina = Pagina.new
  end

  # GET /paginas/1/edit
  def edit
  end

  # POST /paginas
  # POST /paginas.json
  def create
    @pagina = Pagina.new(pagina_params)
    @pagina.produto = @produto

    respond_to do |format|
      if @pagina.save
        format.html { redirect_to edit_produto_pagina_path(@produto, @pagina), notice: 'Pagina was successfully created.' }
        format.json { render :show, status: :created, location: @pagina }
      else
        format.html { render :new }
        format.json { render json: @pagina.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /paginas/1
  # PATCH/PUT /paginas/1.json
  def update
    respond_to do |format|
      if @pagina.update(pagina_params)
        format.html { redirect_to edit_produto_pagina_path(@produto, @pagina), notice: 'Pagina was successfully updated.' }
        format.json { render :show, status: :ok, location: @pagina }
      else
        format.html { render :edit }
        format.json { render json: @pagina.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /paginas/1
  # DELETE /paginas/1.json
  def destroy
    @pagina.destroy
    respond_to do |format|
      format.html { redirect_to produto_paginas_path(@produto), notice: 'Pagina was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_produto
      @produto = Produto.find(params[:produto_id])
    end

    def set_pagina
      @pagina = Pagina.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def pagina_params
      params.require(:pagina).permit(:nome, :slug, :conteudo, :produto_id, :pagina_id, :inicio, :upsell_id)
    end
end
