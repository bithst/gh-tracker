# frozen_string_literal: true
require 'net/http'

class Req
  def self.get(path, options = nil)
    uri = URI(path)
    uri.query = URI.encode_www_form(options) if options.present?

    res = Net::HTTP.get_response(uri)
    format_response(res)
  end

  def self.format_response(res)
    {
      code: res.code,
      body: res['content-type'].include?('application/json') ? JSON.parse(res.body) : res.body
    }
  end
end
