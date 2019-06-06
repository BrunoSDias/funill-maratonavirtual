class ConjuntoGruposCorrida
  def self.find(slug)
    grupo = Rest.show("#{HOST_API}/conjunto_grupos_corridas/slug/#{slug}.json", @aluno_id)
    OpenStruct.new(grupo)
  end
end
