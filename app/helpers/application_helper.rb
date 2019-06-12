module ApplicationHelper
  def parse_html(conteudo)
  	conteudo = conteudo.gsub(/\{\{include_grupo_selecione.*?\}\}/, render('conjunto_grupo_corrida'))
  	conteudo = conteudo.gsub(/\{\{include_pagamento_99run.*?\}\}/, render('include_pagamento_99run'))
  	conteudo = conteudo.gsub(/\{\{include_pedidos_99run.*?\}\}/, render('include_pedidos_99run'))
  	conteudo = conteudo.gsub(/\{\{include_usuario_99run.*?\}\}/, render('include_usuario_99run'))
  end
end
