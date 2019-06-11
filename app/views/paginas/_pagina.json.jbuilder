json.extract! pagina, :id, :nome, :slug, :conteudo, :produto_id, :created_at, :updated_at
json.slug_proxima pagina.proxima_pagina.slug
json.slug_produto pagina.produto.slug