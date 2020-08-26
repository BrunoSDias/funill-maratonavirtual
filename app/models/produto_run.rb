class ProdutoRun
  def self.find(auth, slug)
    produto = Rest.show(auth, "#{HOST_API}/produtos/slug/#{slug}.json")
    OpenStruct.new(produto)
  end
end
