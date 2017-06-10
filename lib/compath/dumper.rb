module Compath
  class Dumper
    def initialize(paths)
      @paths = paths.each_with_object({}) do |path, hash|
        hash[path] = Guide.new(path)
      end
    end

    def dump
      @paths.values.map do |path|
        scan_target = true
        scan_target = path.ancestors.all?(&:scan_children)
        next unless scan_target
        path.to_object
      end.compact
    end
    alias_method :dump_hash, :dump

    def dump_yaml
      YAML.dump(dump_hash)
    end
  end
end
