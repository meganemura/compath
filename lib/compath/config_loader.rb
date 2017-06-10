module Compath
  module ConfigLoader
    module_function
    def load(config)
      conf = YAML.load(config)

      guides = conf.map do |guide_hash|
        path = guide_hash.keys.first
        options = guide_hash.values.first
        options = options.each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
        end
        Guide.new(path, **options)
      end
    end
  end
end
