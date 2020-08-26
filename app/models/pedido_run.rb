class PedidoRun
  def self.find(auth, id)
    pedido = Rest.show(auth, "#{HOST_API}/pedidos/#{id}.json")
    OpenStruct.new(pedido)
  end
end
