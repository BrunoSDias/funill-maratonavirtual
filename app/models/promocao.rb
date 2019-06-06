class Promocao < ApplicationRecord
  belongs_to :upsell
  has_many :item_promocoes, :dependent => :delete_all
end
