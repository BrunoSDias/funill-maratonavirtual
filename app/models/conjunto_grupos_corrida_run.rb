class ConjuntoGruposCorridaRun
  def self.find(slug)
    grupo = Rest.show("#{HOST_API}/conjunto_grupos_corridas/slug/#{slug}.json")
    OpenStruct.new(grupo)
  end
end
