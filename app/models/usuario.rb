class Usuario
  def self.find(auth, email, telefone=nil, cod_marketing=nil, grupo_corrida_id=nil)
    grupo = Rest.show(auth, "#{HOST_API}/usuarios/busca-ou-cria.json?email=#{email}&telefone=#{telefone}&cod_marketing=#{cod_marketing}&grupo_corrida_id=#{grupo_corrida_id}")
    OpenStruct.new(grupo)
  end

  def self.find_by_id(auth, id)
    grupo = Rest.show(auth, "#{HOST_API}/usuarios/#{id}.json?desafio_id=0")
    OpenStruct.new(grupo)
  end

  def self.loga_guest()
    grupo = Rest.post("", "#{HOST_API}/usuarios/loga_guest.json")
    OpenStruct.new(grupo)
  end
end