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
      status, headers, response = @app.call(env)

      if timestamp - @connections_timestamp > Notsofast::Config.limit_expiry
        puts "clearing connections cache"
        @connections_timestamp = timestamp
        @connections = {}
      end

      ip_address = remote_ip(env)

      puts Notsofast::Config.whitelist.include?(ip_address)
      unless Notsofast::Config.whitelist.include?(ip_address)
        if Notsofast::Config.blacklist.include?(ip_address)
          response = Rack::Response.new
          response.write 'Your IP Address has been blacklisted'
          response.status = 403
          response.finish
          return
        else
          puts "checking the content "
          if (headers["Content-Type"].nil? && Notsofast::Config.response_types.empty?) || (headers["Content-Type"].present? && Notsofast::Config.response_types.present? && Notsofast::Config.response_types.select{|r| headers["Content-Type"].include?(r)}.count > 0)
            puts "matched content type"
            if @connections[ip_address]
              @connections[ip_address] += 1
            else
              @connections[ip_address] = 1
            end
            puts @connections

            if @connections[ip_address] > Notsofast::Config.request_limit
              response = Rack::Response.new
              response.write 'Rate Limited'
              response.status = 429
              response.finish
            end
          end
        end
      end
      [status, headers, response]
    end
  end
end
