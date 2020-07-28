class Acao99runController < ApplicationController
  skip_before_action :authenticate_user!
  skip_before_action :verify_authenticity_token

  def login_compra_grupo_corrida
    usuario = Usuario.find(params[:email], params[:telefone], params[:cod_marketing], params[:grupo_corrida_id])
    pagina = Pagina.find(params[:pagina_id])
    grupo_corrida = GrupoCorridaRun.find(params[:grupo_corrida_id])

    organizador = grupo_corrida.organizador

    if usuario.id.blank?
      redirect_to "/#{pagina.produto.slug}/#{pagina.slug}"
      return
    end

    kit_escolhido = nil
    if params[:kit_id].present?
      kit_escolhido = {
        id: params[:kit_id],
        tamanho_camiseta: params[:tamanho_camiseta],
        preco_kit: params[:preco_kit].to_f
      }
    end

    cookies[:usuario] = {value: JSON.parse(usuario.to_json)["table"].to_json, expires: 1.year.from_now, httponly: false}
    cookies[:funil] = {
      value: {
        pagar_com_boleto: params[:pagar_com_boleto],
        usuario_id: usuario.id,
        pagina_id: pagina.id,
        carrinho:[
          grupo_inscricao: {
            id: grupo_corrida.id,
            preco: (params[:preco] || grupo_corrida.preco).to_f,
            kit_escolhido: kit_escolhido,
            organizador: organizador
          }
        ]
      }.to_json,
      expires: 1.year.from_now, httponly: false
    }

    redirect_to "/#{pagina.produto.slug}/#{pagina.proxima_pagina.slug}"
  end

  def captura_email
    usuario = Usuario.find(params[:email])

    if usuario["telefone"].present?
      redirect_to "#{CURSOS_URL}/login?token=#{usuario["token"]}"
      return
    end

    pagina = Pagina.find(params[:pagina_id])

    cookies[:usuario] = {value: JSON.parse(usuario.to_json)["table"].to_json, expires: 1.year.from_now, httponly: false}

    redirect_to "/#{pagina.produto.slug}/#{pagina.proxima_pagina.slug}"
  end

  def captura_telefone
    usuario = Usuario.find(params[:email], params[:telefone])

    if usuario["email"].present?
      redirect_to "#{CURSOS_URL}/login?token=#{usuario["token"]}"
      return
    end

    pagina = Pagina.find(params[:pagina_id])

    cookies[:usuario] = {value: JSON.parse(usuario.to_json)["table"].to_json, expires: 1.year.from_now, httponly: false}

    redirect_to "#{CURSOS_URL}/login?token=#{usuario["token"]}"
  end
end
