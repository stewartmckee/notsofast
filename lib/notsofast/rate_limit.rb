module Notsofast
  class RateLimit

    def initialize(app)
      @app = app
      @connections = {}
      @connections_timestamp = timestamp
    end

    def timestamp
      DateTime.now.to_i
    end

    def remote_ip(env)
      env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_ADDR']
    end

    def call(env)

      if timestamp - @connections_timestamp > Notsofast::Config.limit_expiry
        @connections_timestamp = timestamp
        @connections = {}
      end

      ip_address = remote_ip(env)

      Rails.logger.info "Checking #{ip_address} for limit on #{env["REQUEST_PATH"]}"

      if Notsofast::Config.whitelist.select{|ip| ip_address.include?(ip) }.empty?
        if Notsofast::Config.blacklist.include?(ip_address)
          response = Rack::Response.new
          response.write 'Your IP Address has been blacklisted'
          response.status = 403
          response.finish

          Rails.logger.info " --- Blacklisted: #{ip_address} ---"
          return [403, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]

        else

          #if (headers["Content-Type"].nil? && Notsofast::Config.response_types.empty?) || (headers["Content-Type"].present? && Notsofast::Config.response_types.present? && Notsofast::Config.response_types.select{|r| headers["Content-Type"].include?(r)}.count > 0)
            if @connections[ip_address]
              @connections[ip_address] += 1
            else
              @connections[ip_address] = 1
            end
            if @connections[ip_address] > Notsofast::Config.request_limit

              Notsofast::Config.notify.call(ip_address, env)
              Rails.logger.info "--- Rate Limited: #{ip_address} ---"
              return [429, { 'Content-Type' => 'text/html', 'Content-Length' => '0' }, []]
            end
          #end
        end
      else
        Rails.logger.info "--- Whitelisted: #{ip_address} ---"
      end
      status, headers, response = @app.call(env)
      [status, headers, response]
    end
  end
end
