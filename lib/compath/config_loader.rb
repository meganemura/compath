module Compath
  module ConfigLoader
    module_function
    def load(config)
      conf = YAML.load(config)

      guides = conf.map do |path, guide|
        if guide.is_a?(Hash)
          # symbolize keys
          options = guide.each_with_object({}) do |(key, value), hash|
            hash[key.to_sym] = value
          end
        else
          # nil or String
          options = {
            scan: true,
            desc: guide,
          }
        end

        # TODO: Bad interface...
        Guide.new(path, **options)
      end
    end
  end
end
