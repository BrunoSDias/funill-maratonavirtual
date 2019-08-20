class ConjuntoGruposCorridaRun
  def self.find(slug, bike=nil)
    grupo = Rest.show("#{HOST_API}/conjunto_grupos_corridas/slug/#{slug}.json?bike=#{bike}")
    OpenStruct.new(grupo)
  end
end
