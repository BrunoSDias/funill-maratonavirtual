json.extract! upsell, :id, :produto_id, :data_inicial, :data_final, :somente_boleto, :somente_cartao, :tentar_a_cada_compra, :mostrar_para_compras_acima_de, :mostrar_para_compras_ate, :created_at, :updated_at
json.url upsell_url(upsell, format: :json)
