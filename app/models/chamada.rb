class Chamada < ApplicationRecord
  default_scope { order(data_criacao: :desc) }
end
