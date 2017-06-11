module Compath
  class GuideBook
    attr_reader :paths
    def initialize(guides)
      @index = guides.each_with_object({}) do |guide, hash|
        hash[guide.to_path] = guide
      end
    end

    def guides
      @index.values
    end

    def merge(new_guides)
      new_guides.each do |guide|
        if @index.key?(guide.to_path)
          @index[guide.to_path] = guide
        end
      end
    end

    def publish
      @index.each_with_object({}) do |(path, guide), hash|
        scan_children = true
        scan_children = guide.ancestors.all? do |ancestor|
          @index[ancestor.to_path].scan_children
        end
        next unless scan_children

        hash.update(guide.to_object)
      end
    end

    def publish_yaml
      YAML.dump(publish)
    end
  end
end
