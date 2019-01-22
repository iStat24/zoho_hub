# frozen_string_literal: true

module ZohoHub
  class Configuration
    attr_accessor :client_id, :secret, :redirect_uri, :api_domain
    attr_writer :debug

    DEFAULT_API_DOMAIN = 'https://accounts.zoho.com'

    def initialize(attrs)
      attrs ||= {}
      @client_id = attrs[:client_id]
      @secret = attrs[:secret]
      @redirect_uri = attrs[:redirect_uri]
      @api_domain = attrs[:api_endpoint] || DEFAULT_API_DOMAIN
    end

    def debug?
      @debug
    end
  end
end
