module ApplicationHelper
  def parse_html(conteudo)
  	conteudo = conteudo.gsub(/\{\{include_grupo_selecione.*?\}\}/, render('conjunto_grupo_corrida'))
  	conteudo = conteudo.gsub(/\{\{include_pagamento_99run.*?\}\}/, render('include_pagamento_99run'))
  end
end
