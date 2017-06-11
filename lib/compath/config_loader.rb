module Compath
  module ConfigLoader
    module_function

    SCAN_FALSE_REGEXP = %r{(?<new_path>[^\*]*)(/\*\*)?/\*$}

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

        # if path is end with `/` character, it represents `scan_children is false`.
        if m = SCAN_FALSE_REGEXP.match(path)
          path = m[:new_path]
          options[:scan] = false
        end

        # TODO: Bad interface...
        Guide.new(path, **options)
      end
    end
  end
end
