json.extract! promocao, :id, :upsell_id, :nome, :tempo_relogio, :se_pago_vai_para, :se_negou_vai_para, :titulo, :subtitulo, :descricao, :created_at, :updated_at
json.url promocao_url(promocao, format: :json)
