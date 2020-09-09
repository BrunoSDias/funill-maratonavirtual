class Cupom < ApplicationRecord
  def self.validos
    uri = URI.parse(URI.escape("#{HOST_API}/cupons_validos.json"))
    headers = {"MaratonaKeyAccess" => TOKEN}
    request = HTTParty.get(uri, :headers => headers)
    if (200...300).include?(request.code.to_i)
      if request.body.present?
        cupons = JSON.parse(request.body)
        cupons = cupons.map { |c| c["codigo"] }.compact

        if cupons.present?
          cupons = cupons
        else
          cupons = []
        end

        return cupons
      end
    end
    return []
  rescue
    return []
  end
end
