json.extract! pagina, :id, :nome, :slug, :conteudo, :produto_id, :created_at, :updated_at

if pagina.proxima_pagina.present?
	json.slug_proxima pagina.proxima_pagina.slug
end

if pagina.proxima_pagina.present?
	json.slug_produto pagina.produto.slug
end
