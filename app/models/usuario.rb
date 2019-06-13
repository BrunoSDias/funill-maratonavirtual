class Usuario
  def self.find(email, telefone, cod_marketing)
    grupo = Rest.show("#{HOST_API}/usuarios/busca-ou-cria.json?email=#{email}&telefone=#{telefone}&cod_marketing=#{cod_marketing}")
    OpenStruct.new(grupo)
  end

  def self.find_by_id(id)
    grupo = Rest.show("#{HOST_API}/usuarios/#{id}.json?desafio_id=0")
    OpenStruct.new(grupo)
  end
end