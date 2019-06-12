class PedidoRun
  def self.find(id)
    pedido = Rest.show("#{HOST_API}/pedidos/#{id}.json")
    OpenStruct.new(pedido)
  end
end
