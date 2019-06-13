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
      @usuario = Usuario.find_by_id(JSON.parse(cookies[:usuario])["id"])
      @usuario.cpf = @usuario.cpf_cnpj
      @usuario.telefone = @usuario.telefone.gsub("+", " ")
      @usuario.cep = @usuario.endereco["cep"]
      @usuario.numero = @usuario.endereco["numero"]
      @usuario.complemento = @usuario.endereco["complemento"]
      @usuario.cidade = @usuario.endereco["cidade"]
      @usuario.estado = @usuario.endereco["estado"]
      @usuario.endereco = @usuario.endereco["endereco"]

      cookies[:usuario] = {value: JSON.parse(@usuario.to_json)["table"].to_json, expires: 1.year.from_now, httponly: false}
    else
      @usuario = OpenStruct.new
    end

    if cookies[:id_pedido].present?
      @pedido = PedidoRun.find(cookies[:id_pedido])
    end
  end

  def upsell
    @pagina = Pagina.find(params[:pagina_id])
    @upsell = @pagina.upsell

    if @upsell.blank?
      render json: {}, status: 204
      return
    end

    if params[:idProximaPromocao].present?
      @promocao = @upsell.promocoes.where(id: params[:idProximaPromocao]).first
    else
      @promocao = @upsell.promocoes.first
    end

  end
end
