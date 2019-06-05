json.extract! produto, :id, :nome, :url, :created_at, :updated_at
json.url produto_url(produto, format: :json)
