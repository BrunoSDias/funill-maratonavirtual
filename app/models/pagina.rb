class Pagina < ApplicationRecord
  belongs_to :produto

  def self.iniciais(produto_id)
  	paginas = Pagina.where(produto_id: produto_id, inicio: true)
  end

  def proxima_pagina
  	Pagina.find(self.pagina_id)
  end

  def proximas_paginas
  	return [] if self.pagina_id.blank?
  	[Pagina.find(self.pagina_id)]
  end
end
