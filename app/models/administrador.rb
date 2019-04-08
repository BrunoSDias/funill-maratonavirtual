class Administrador < ApplicationRecord
  validates :nome, :email, :senha, presence: true
end
