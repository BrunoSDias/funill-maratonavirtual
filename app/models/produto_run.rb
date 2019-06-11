class ProdutoRun
  def self.find(slug)
    produto = Rest.show("#{HOST_API}/produtos/slug/#{slug}.json")
    OpenStruct.new(produto)
  end
end
