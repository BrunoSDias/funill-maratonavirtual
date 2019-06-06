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

    @conteudo = paginas.first.conteudo
    tag_grupo = @conteudo.scan(/\{\{include_grupo_selecione.*?\}\}/) rescue ""
    if tag_grupo.present?
      slug_grupo = tag_grupo.first.gsub(/\{\{include_grupo_selecione:|\}\}/, '').strip
      @conjunto_grupo_corrida = ConjuntoGruposCorrida.find(slug_grupo)
    end

  end
end
