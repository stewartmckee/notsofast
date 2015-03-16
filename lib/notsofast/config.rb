module Notsofast
  class Config

    @whitelist = []
    @blacklist = []
    @request_limit = 100
    @response_types = ["text/html"]
    @limit_expiry = 60
    @notify = Proc.new{|ip, env| }

    def self.configure(&block)
      yield self
    end

    def self.whitelist=(value)
      @whitelist = value
    end

    def self.blacklist=(value)
      @blacklist = value
    end

    def self.request_limit=(value)
      @request_limit = value
    end

    def self.response_types=(value)
      @response_types = value
    end

    def self.limit_expiry=(value)
      @limit_expiry = value
    end

    def self.notify=(value)
      @notify = value
    end

    def self.whitelist
      @whitelist
    end

    def self.blacklist
      @blacklist
    end

    def self.request_limit
      @request_limit
    end

    def self.response_types
      @response_types
    end

    def self.limit_expiry
      @limit_expiry
    end

    def self.notify
      @notify
    end

  end
end