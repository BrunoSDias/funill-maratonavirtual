class Rest
  def self.all(url, aluno_id=nil, query={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN}
    headers["AlunoId"] = aluno_id.to_s if aluno_id.present?
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

  def self.exist?(url, aluno_id=nil, query={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN}
    headers["AlunoId"] = aluno_id.to_s if aluno_id.present?
    request = HTTParty.get(uri, :query => query, :headers => headers)
    if (200...300).include?(request.code.to_i)
      return true
    end
    return false
  rescue
    return false
  end

  def self.show(url, aluno_id=nil, query={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN}
    headers["AlunoId"] = aluno_id.to_s if aluno_id.present?
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

  def self.post(url, data={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN}
    headers["AlunoId"] = data[:id].to_s
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

  def self.put(url, data={})
    uri = URI.parse(URI.escape(url))
    headers = {"MaratonaKeyAccess" => TOKEN}
    headers["AlunoId"] = data[:id].to_s
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
