class ConjuntoGruposCorridaRun
  def self.find(slug, tipo="corrida")
    query = ""
    if tipo == "bike"
      query += "&bike=true"
    elsif tipo == "natacao"
      query += "&natacao=true"
    end
    grupo = Rest.show("#{HOST_API}/conjunto_grupos_corridas/slug/#{slug}.json?#{query}")
    OpenStruct.new(grupo)
  end
end
