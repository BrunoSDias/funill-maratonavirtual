class Pagina < ApplicationRecord
  belongs_to :produto

  def self.iniciais(produto_id)
  	paginas = Pagina.where(produto_id: produto_id, inicio: true)
  end

  def proxima_pagina
  	Pagina.find(self.pagina_id)
  rescue
    nil
  end

  def upsell
    Upsell.find(self.upsell_id)
  rescue
    nil
  end

  def proximas_paginas
  	return [] if self.pagina_id.blank?
    paginas = Pagina.where(id: self.pagina_id)
    if paginas.present?
  	  return [paginas.first]
    else
      return []
    end
  end
end
