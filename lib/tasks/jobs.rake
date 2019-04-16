namespace :jobs do
  desc "Extrair dados do Total Voice por mes"
  task extract_month: :environment do
    @client = TotalVoice::API.new(ENV['TOKENVOICE'])

    # date_inicial = DateTime.now.beginning_of_day
    date_inicial = DateTime.parse('2018-11-01T00:00:00-03:00').beginning_of_day
    date_final = date_inicial.end_of_day
    date_final_mes = date_inicial.end_of_month

    while(date_final_mes >= date_final)
      date_final = date_inicial.end_of_day
      chamadas = @client.chamada.relatorio(date_inicial.strftime("%Y-%m-%dT%H:%H:%S-03:00"), date_final.strftime("%Y-%m-%dT%H:%H:%S-03:00"))

      puts "De #{date_inicial.strftime("%d-%m-%Y %H:%H:%S")} até #{date_final.strftime("%d-%m-%Y %H:%H:%S")} - status: #{chamadas["status"]} - quantidade: #{(chamadas["dados"]["relatorio"].length rescue 0)}"

      if (200..300).include?(chamadas["status"])
        chamadas = chamadas["dados"]["relatorio"]
        chamadas.each do |voice|
          camadas = Chamada.where(chamada_voice_id: voice["id"])
          if camadas.count == 0
            chamada = Chamada.new
            chamada.chamada_voice_id = voice["id"]
          else
            chamada = camadas.first
          end

          chamada.data_criacao = voice["data_criacao"]

          # if chamada.data_criacao > DateTime.parse("2018/11/30 00:00:00") && chamada.data_criacao <= DateTime.parse("2018/12/01 00:00:00") 
          #   debugger
          #   x = ""
          # end

          chamada.ativa = voice["ativa"]
          chamada.url_gravacao = voice["url_gravacao"]
          chamada.cliente_id = voice["cliente_id"]
          chamada.conta_id = voice["conta_id"]
          chamada.ramal_id_origem = voice["ramal_id_origem"]
          chamada.tags = voice["tags"]
          chamada.login = voice["origem"]["ramal"]["login"] rescue ""
          chamada.status_geral = voice["status_geral"]
          chamada.origem_data_inicio = voice["origem"]["data_inicio"]
          chamada.origem_numero = voice["origem"]["numero"]
          chamada.origem_tipo = voice["origem"]["tipo"]
          chamada.origem_status = voice["origem"]["status"]
          chamada.origem_duracao_segundos = voice["origem"]["duracao_segundos"]
          chamada.origem_duracao = Time.parse(voice["origem"]["duracao"]) rescue 0
          chamada.origem_duracao_string = voice["origem"]["duracao"]
          chamada.origem_duracao_cobrada_segundos = voice["origem"]["cobrada_segundos"]
          chamada.origem_duracao_cobrada = Time.parse(voice["origem"]["duracao_cobrada"]) rescue 0
          chamada.origem_duracao_cobrada_string = voice["origem"]["duracao_cobrada"]
          chamada.origem_duracao_falada_segundos = voice["origem"]["duracao_falada_segundos"]
          chamada.origem_duracao_falada = Time.parse(voice["origem"]["duracao_falada"]) rescue 0
          chamada.origem_duracao_falada_string = voice["origem"]["duracao_falada"]
          chamada.origem_preco = voice["origem"]["preco"]
          chamada.origem_motivo_desconexao = voice["origem"]["motivo_desconexao"]
          chamada.destino_data_inicio = voice["destino"]["data_inicio"]
          chamada.destino_numero = voice["destino"]["numero"]
          chamada.destino_tipo = voice["destino"]["tipo"]
          chamada.destino_status = voice["destino"]["status"]
          chamada.destino_duracao_segundos = voice["destino"]["duracao_segundos"]
          chamada.destino_duracao = Time.parse(voice["destino"]["duracao"]) rescue 0
          chamada.destino_duracao_string = voice["destino"]["duracao"]
          chamada.destino_duracao_cobrada_segundos = voice["destino"]["duracao_cobrada_segundos"]
          chamada.destino_duracao_cobrada = Time.parse(voice["destino"]["duracao_cobrada"]) rescue 0
          chamada.destino_duracao_cobrada_string = voice["destino"]["duracao_cobrada"]
          chamada.destino_duracao_falada_segundos = voice["destino"]["duracao_falada_segundos"]
          chamada.destino_duracao_falada = Time.parse(voice["destino"]["duracao_falada"]) rescue 0
          chamada.destino_duracao_falada_string = voice["destino"]["duracao_falada"]
          chamada.destino_preco = voice["destino"]["preco"]
          chamada.destino_motivo_desconexao = voice["destino"]["data_inicio"]
          chamada.save

          puts "*"
        end
      end

      date_inicial = date_inicial + 1.day
    end
  end


  desc "Extrair dados do Total Voice por dia"
  task extract_day: :environment do
    @client = TotalVoice::API.new(ENV['TOKENVOICE'])

    date_inicial = DateTime.now.beginning_of_day
    date_final = date_inicial.end_of_day
    date_final_mes = date_final

    while(date_final_mes >= date_final)
      date_final = date_inicial.end_of_day
      chamadas = @client.chamada.relatorio(date_inicial.strftime("%Y-%m-%dT%H:%H:%S-03:00"), date_final.strftime("%Y-%m-%dT%H:%H:%S-03:00"))

      puts "De #{date_inicial.strftime("%d-%m-%Y %H:%H:%S")} até #{date_final.strftime("%d-%m-%Y %H:%H:%S")} - status: #{chamadas["status"]} - quantidade: #{(chamadas["dados"]["relatorio"].length rescue 0)}"

      if (200..300).include?(chamadas["status"])
        chamadas = chamadas["dados"]["relatorio"]
        chamadas.each do |voice|
          if Chamada.where(chamada_voice_id: voice["id"]).count == 0
            chamada = Chamada.new
            chamada.data_criacao = voice["data_criacao"]
            chamada.ativa = voice["ativa"]
            chamada.url_gravacao = voice["url_gravacao"]
            chamada.cliente_id = voice["cliente_id"]
            chamada.conta_id = voice["conta_id"]
            chamada.ramal_id_origem = voice["ramal_id_origem"]
            chamada.tags = voice["tags"]
            chamada.login = voice["origem"]["ramal"]["login"]
            chamada.status_geral = voice["status_geral"]
            chamada.origem_data_inicio = voice["origem"]["data_inicio"]
            chamada.origem_numero = voice["origem"]["numero"]
            chamada.origem_tipo = voice["origem"]["tipo"]
            chamada.origem_status = voice["origem"]["status"]
            chamada.origem_duracao_segundos = voice["origem"]["duracao_segundos"]
            chamada.origem_duracao = Time.parse(voice["origem"]["duracao"])
            chamada.origem_duracao_string = voice["origem"]["duracao"]
            chamada.origem_duracao_cobrada_segundos = voice["origem"]["cobrada_segundos"]
            chamada.origem_duracao_cobrada = Time.parse(voice["origem"]["duracao_cobrada"])
            chamada.origem_duracao_cobrada_string = voice["origem"]["duracao_cobrada"]
            chamada.origem_duracao_falada_segundos = voice["origem"]["duracao_falada_segundos"]
            chamada.origem_duracao_falada = Time.parse(voice["origem"]["duracao_falada"])
            chamada.origem_duracao_falada_string = voice["origem"]["duracao_falada"]
            chamada.origem_preco = voice["origem"]["preco"]
            chamada.origem_motivo_desconexao = voice["origem"]["motivo_desconexao"]
            chamada.destino_data_inicio = voice["destino"]["data_inicio"]
            chamada.destino_numero = voice["destino"]["numero"]
            chamada.destino_tipo = voice["destino"]["tipo"]
            chamada.destino_status = voice["destino"]["status"]
            chamada.destino_duracao_segundos = voice["destino"]["duracao_segundos"]
            chamada.destino_duracao = Time.parse(voice["destino"]["duracao"])
            chamada.destino_duracao_string = voice["destino"]["duracao"]
            chamada.destino_duracao_cobrada_segundos = voice["destino"]["duracao_cobrada_segundos"]
            chamada.destino_duracao_cobrada = Time.parse(voice["destino"]["duracao_cobrada"])
            chamada.destino_duracao_cobrada_string = voice["destino"]["duracao_cobrada"]
            chamada.destino_duracao_falada_segundos = voice["destino"]["duracao_falada_segundos"]
            chamada.destino_duracao_falada = Time.parse(voice["destino"]["duracao_falada"])
            chamada.destino_duracao_falada_string = voice["destino"]["duracao_falada"]
            chamada.destino_preco = voice["destino"]["preco"]
            chamada.destino_motivo_desconexao = voice["destino"]["data_inicio"]
            chamada.save
          end

          puts "*"
        end
      end

      date_inicial = date_inicial + 1.day
    end
  end
end