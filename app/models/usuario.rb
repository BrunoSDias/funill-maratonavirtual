class Usuario
  def self.find(email, telefone, cod_marketing)
    grupo = Rest.show("#{HOST_API}/usuarios/busca-ou-cria.json?email=#{email}&telefone=#{telefone}&cod_marketing=#{cod_marketing}")
    OpenStruct.new(grupo)
  end
end