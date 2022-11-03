module App
  class << self

    attr_reader :root

    def root_path(path)
      File.join(root, path)
    end

    def require_files(files)
      files.uniq.each { |file| require file }
    end
  
    def require_common
      puts "Requiring basic files ..."
      require_constants
      require_files Dir[root_path('app/services/common/*.rb')]
      require_files Dir[root_path('app/lib/**/*.rb')]
      puts "Required basic files."
    end

    def require_constants
      puts "Requiring constants"
      puts "No constants as of now"
    end

    def connect_firebase_instances(instances)
      instances.each do |config|
        self.class.send(:attr_reader, :"#{config[:instance]}")
        instance_variable_set(:"@#{config[:instance]}", Qr::Firebase.new(config))
      end
    end


  end
  @root = __dir__
end