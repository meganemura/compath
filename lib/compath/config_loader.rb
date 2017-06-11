module Compath
  module ConfigLoader
    module_function
    def load(config)
      conf = YAML.load(config)

      guides = conf.map do |path, guide|
        # symbolize keys
        options = guide.each_with_object({}) do |(key, value), hash|
          hash[key.to_sym] = value
        end

        # TODO: Bad interface...
        Guide.new(path, **options)
      end
    end
  end
end
