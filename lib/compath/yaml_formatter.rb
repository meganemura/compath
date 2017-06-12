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
      @formatters ||= [
        remove_trailing_space_formatter,
        remove_quotes_from_keys_formatter,
      ]
    end

    def remove_trailing_space_formatter
      lambda do |yaml|
        yaml.lines.map(&:rstrip).map {|x| "#{x}\n" }.join
      end
    end

    QUOTED_KEY_REGEXP = /^"(?<key>[^"]+)":(?<value>.*)/
    def remove_quotes_from_keys_formatter
      lambda do |yaml|
        lines = yaml.lines.map do |line|
          if m = QUOTED_KEY_REGEXP.match(line)
            "#{m[:key]}: #{m[:value]}"
          else
            line.chomp
          end
        end

        lines.map {|x| "#{x}\n" }.join
      end
    end
  end
end
