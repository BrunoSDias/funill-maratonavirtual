class FunilController < ApplicationController
  skip_before_action :authenticate_user!
  layout "funil"

  def slug
    produtos = Produto.where(slug: params[:slug_produto])
    if produtos.count == 0
      raise ActionController::RoutingError.new('Not Found') if @conteudo.blank?
    end

    paginas = Pagina.where(slug: params[:slug_pagina])
    if paginas.count == 0
      raise ActionController::RoutingError.new('Not Found') if @conteudo.blank?
    end

    @pagina = paginas.first
    @conteudo = @pagina.conteudo
    tag_grupo = @conteudo.scan(/\{\{include_grupo_selecione.*?\}\}/) rescue ""
    if tag_grupo.present?
      slug_grupo = tag_grupo.first.gsub(/\{\{include_grupo_selecione:|\}\}/, '').strip
      @conjunto_grupo_corrida = ConjuntoGruposCorridaRun.find(slug_grupo)
    end

    tag_pagamento = @conteudo.scan(/\{\{include_pagamento_99run.*?\}\}/) rescue ""
    if tag_pagamento.present?
      slug_produto = tag_pagamento.first.gsub(/\{\{include_pagamento_99run:|\}\}/, '').strip
      @produto = ProdutoRun.find(slug_produto)
    end

    if cookies[:funil].present?
      @boleto = JSON.parse(cookies[:funil])["pagar_com_boleto"] rescue nil
    end

    if cookies[:usuario].present?
      @usuario = OpenStruct.new(JSON.parse(cookies[:usuario]))
    end

    if cookies[:id_pedido].present?
      @pedido = PedidoRun.find(cookies[:id_pedido])
    end
  end

  def upsell
    @pagina = Pagina.find(params[:pagina_id])
    @upsell = @pagina.upsell
    if params[:idProximaPromocao].present?
      @promocao = @upsell.promocoes.where(id: params[:idProximaPromocao]).first
    else
      @promocao = @upsell.promocoes.first
    end

    if @upsell.blank?
      render json: {}, status: 204
      return
    end

  end
end
