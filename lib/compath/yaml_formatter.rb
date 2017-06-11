module Compath
  class YamlFormatter
    attr_accessor :yaml

    def initialize(yaml)
      @yaml = yaml
    end

    def format
      formatters.each do |formatter|
        self.yaml = formatter.call(yaml)
      end
      yaml
    end

    def formatters
      @formatters ||= [remove_trailing_space_formatter]
    end

    def remove_trailing_space_formatter
      lambda do |yaml|
        yaml.lines.map(&:rstrip).join("\n")
      end
    end
  end
end
