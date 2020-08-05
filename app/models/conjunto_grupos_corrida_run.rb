class ConjuntoGruposCorridaRun
  def self.find(slug, tipo="corrida")
    query = ""
    if tipo == "bike"
      query += "&bike=true"
    elsif tipo == "natacao"
      query += "&natacao=true"
    elsif tipo == "duathlon"
      query += "&duathlon=true"
    elsif tipo == "triathlon"
      query += "&triathlon=true"
    end
    
    grupo = Rest.show("#{HOST_API}/conjunto_grupos_corridas/slug/#{slug}.json?#{query}")
    OpenStruct.new(grupo)
  end
end