class Usuario
  def self.find(email, telefone=nil, cod_marketing=nil, grupo_corrida_id=nil)
    grupo = Rest.show("#{HOST_API}/usuarios/busca-funil.json?email=#{email}&telefone=#{telefone}&cod_marketing=#{cod_marketing}&grupo_corrida_id=#{grupo_corrida_id}")
    OpenStruct.new(grupo)
  end

  def self.find_by_id(id)
    grupo = Rest.show("#{HOST_API}/usuarios/#{id}.json?desafio_id=0")
    OpenStruct.new(grupo)
  end
end