class Acao99runController < ApplicationController
  skip_before_action :verify_authenticity_token

  def login_compra_grupo_corrida
    usuario = Usuario.find(params[:email], params[:telefone])
    pagina = Pagina.find(params[:pagina_id])
    grupo_corrida_id = params[:grupo_corrida_id]
    preco = params[:preco]

    grupo_corrida_id = 42
    preco = 39

    cookies[:funil] = {
      value: {
        usuario_id: usuario.id,
        pagina_id: pagina.id,
        carrinho:[
          grupo_inscricao: {
            id: grupo_corrida_id,
            preco: preco
          }
        ]
      }.to_json,
      expires: 1.year.from_now, httponly: false 
    }

    redirect_to "/#{pagina.produto.slug}/#{pagina.proxima_pagina.slug}"
  end
end
