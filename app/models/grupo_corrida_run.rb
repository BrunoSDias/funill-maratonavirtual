class GrupoCorridaRun
  def self.find(id)
    grupo = Rest.show("#{HOST_API}/grupo_corridas/#{id}.json")
    OpenStruct.new(grupo)
  end
end
