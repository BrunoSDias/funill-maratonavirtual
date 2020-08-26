class GrupoCorridaRun
  def self.find(auth, id)
    grupo = Rest.show(auth, "#{HOST_API}/grupo_corridas/#{id}.json")
    OpenStruct.new(grupo)
  end
end
