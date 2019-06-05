json.extract! pagina, :id, :nome, :slug, :conteudo, :produto_id, :created_at, :updated_at
json.url pagina_url(pagina, format: :json)
