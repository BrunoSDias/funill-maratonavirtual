class Upsell < ApplicationRecord
  belongs_to :produto
  has_many :promocoes, :dependent => :delete_all
end
