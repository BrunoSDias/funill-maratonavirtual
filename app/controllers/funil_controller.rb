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
    elsif paginas.first.valido_com_cupom
      @cupons = Cupom.validos
    end

    @pagina = paginas.first
    @conteudo = @pagina.conteudo
    tag_grupo = @conteudo.scan(/\{\{include_grupo_selecione.*?\}\}/) rescue ""
    if tag_grupo.present?
      @slug_grupo = tag_grupo.first.gsub(/\{\{include_grupo_selecione:|\}\}/, '').strip
      @conjunto_grupo_corrida = ConjuntoGruposCorridaRun.find(@slug_grupo)
      @conjunto_grupo_corrida_bike = ConjuntoGruposCorridaRun.find(@slug_grupo, "bike")
      @conjunto_grupo_corrida_natacao = ConjuntoGruposCorridaRun.find(@slug_grupo, "natacao")
      @conjunto_grupo_corrida_duathlon = ConjuntoGruposCorridaRun.find(@slug_grupo, "duathlon")
      @conjunto_grupo_corrida_triathlon = ConjuntoGruposCorridaRun.find(@slug_grupo, "triathlon")
    end

    tag_pagamento = @conteudo.scan(/\{\{include_pagamento_99run.*?\}\}/) rescue ""
    if tag_pagamento.present?
      slug_produto = tag_pagamento.first.gsub(/\{\{include_pagamento_99run:|\}\}/, '').strip
      @produto = ProdutoRun.find(slug_produto)
    end

    if cookies[:funil].present?
      @boleto = JSON.parse(cookies[:funil])["pagar_com_boleto"] rescue nil
      @preco = JSON.parse(cookies[:funil])["carrinho"][0]["grupo_inscricao"]["kit_escolhido"]["preco_kit"].to_s.gsub(".", ",") || JSON.parse(cookies[:funil])["carrinho"][0]["grupo_inscricao"]["preco"].to_s.gsub(".", ",") rescue ""
      unless @preco.present?
        @preco = JSON.parse(cookies[:funil])["carrinho"][0]["grupo_inscricao"]["preco"]
      end
    end

    if cookies[:usuario].present?
      @usuario = Usuario.find_by_id(JSON.parse(cookies[:usuario])["id"])
      @usuario.cpf = @usuario.cpf_cnpj rescue ""
      @usuario.telefone = @usuario.telefone.gsub("+", " ") rescue ""
      @usuario.cep = @usuario.endereco["cep"] rescue ""
      @usuario.numero = @usuario.endereco["numero"] rescue ""
      @usuario.complemento = @usuario.endereco["complemento"] rescue ""
      @usuario.cidade = @usuario.endereco["cidade"] rescue ""
      @usuario.estado = @usuario.endereco["estado"] rescue ""
      @usuario.endereco = @usuario.endereco["endereco"] rescue ""

      if @usuario.muda_senha
        @mudasenha = true
      end

      # @usuario.id = 15942
      # @usuario.cpf =  ""
      # @usuario.telefone = ""
      # @usuario.cep = ""
      # @usuario.numero = ""
      # @usuario.complemento = ""
      # @usuario.cidade = ""
      # @usuario.estado = ""
      # @usuario.endereco = ""

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
