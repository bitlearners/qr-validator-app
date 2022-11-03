module Firebase
  class Client
    # Aliasing these to unique method names to allow easily doing a rescue_from

    alias_method :update_firebase, :update
    alias_method :delete_firebase, :delete
    alias_method :set_firebase, :set
  end
end

module Qr
  class Firebase
    attr_reader :conn, :url, :auth_key, :rdb_path

    def initialize(config)
      @url = config[:firebase_db_url]
      @auth_key = config[:firebase_auth_key]
      @rdb_path = config[:firebase_db_root_path]
      @conn = connection
    end

    def update(path, data)
      connection.update(path, data)
    end

    def connection
      return conn if conn
      #Ycs::Logger::Base.info "firebase connection"

      if url && auth_key && rdb_path
        base_uri = [url, rdb_path].join('/')
        @conn = ::Firebase::Client.new(base_uri, auth_key)
      end
      conn
    end
  end
end