class Rest
  def self.all(auth_token, url, query={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN, "UsrAuthToken" => auth_token}
    request = HTTParty.get(uri, :query => query, :headers => headers)
    if (200...300).include?(request.code.to_i)
      if request.body.present?
        return JSON.parse(request.body)
      end
    end
    return []
  rescue
    return []
  end

  def self.exist?(auth_token, url, query={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN, "UsrAuthToken" => auth_token}
    request = HTTParty.get(uri, :query => query, :headers => headers)
    if (200...300).include?(request.code.to_i)
      return true
    end
    return false
  rescue
    return false
  end

  def self.show(auth_token, url, query={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN, "UsrAuthToken" => auth_token}
    request = HTTParty.get(uri, :query => query, :headers => headers)
    if (200...300).include?(request.code.to_i)
      if request.body.present?
        data = JSON.parse(request.body)
        data = data.first if data.is_a?(Array)
        return data
      end
    end
    return {}
  rescue
    return {}
  end

  def self.post(auth_token, url, data={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN, "UsrAuthToken" => auth_token}
    request = HTTParty.post(uri, :body => data, :headers => headers)
    if (200...300).include?(request.code.to_i)
      if request.body.present?
        return JSON.parse(request.body);
      end
    else
      if request.body.present?
        return JSON.parse(request.body);
      end
      return {}
    end
  rescue Exception => erro
    return {}
  end

  def self.put(auth_token, url, data={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN, "UsrAuthToken" => auth_token}
    request = HTTParty.put(uri, :body => data, :headers => headers)
    if (200...300).include?(request.code.to_i)
      if request.body.present?
        return JSON.parse(request.body);
      end
    else
      if request.body.present?
        return JSON.parse(request.body);
      end
      return {}
    end
  rescue Exception => erro
    return {}
  end
end
