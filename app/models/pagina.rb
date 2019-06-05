class Pagina < ApplicationRecord
  belongs_to :produto

  def pagina
  	Pagina.find(self.pagina_id)
  end
end
