class Acao99runController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login_compra_grupo_corrida
    usuario = Usuario.find(params[:email], params[:telefone], params[:cod_marketing])
    pagina = Pagina.find(params[:pagina_id])
    grupo_corrida = GrupoCorridaRun.find(params[:grupo_corrida_id])

    cookies[:usuario] = {value: JSON.parse(usuario.to_json)["table"].to_json, expires: 1.year.from_now, httponly: false}
    cookies[:funil] = {
      value: {
        pagar_com_boleto: params[:pagar_com_boleto],
        usuario_id: usuario.id,
        pagina_id: pagina.id,
        carrinho:[
          grupo_inscricao: {
            id: grupo_corrida.id,
            preco: grupo_corrida.preco
          }
        ]
      }.to_json,
      expires: 1.year.from_now, httponly: false 
    }

    redirect_to "/#{pagina.produto.slug}/#{pagina.proxima_pagina.slug}"
  end
end
