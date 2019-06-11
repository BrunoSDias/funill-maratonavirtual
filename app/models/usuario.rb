class Usuario
  def self.find(email, telefone)
    grupo = Rest.show("#{HOST_API}/usuarios/busca-ou-cria.json?email=#{email}&telefone=#{telefone}")
    OpenStruct.new(grupo)
  end
end
