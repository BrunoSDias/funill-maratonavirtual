class Cupom < ApplicationRecord
  def self.validos
    uri = URI.parse(URI.escape("#{HOST_API}/cupons_validos.json"))
    headers = {"MaratonaKeyAccess" => TOKEN}
    request = HTTParty.get(uri, :headers => headers)
    debugger
    if (200...300).include?(request.code.to_i)
      if request.body.present?
        return JSON.parse(request.body)
      end
    end
    return []
  rescue
    return []
  end
end
