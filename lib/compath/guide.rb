module Compath
  class Guide
    extend Forwardable

    def_delegators :@pathname, :directory?, :executable?, :to_path
    attr_reader :pathname, :scan_children

    def initialize(path, scan: true, desc: nil)
      # claenpath is for dirty configurated guide
      @pathname = Pathname.new(path).cleanpath
      @scan_children = scan
      @description = desc
    end

    def children
      pathname.children.map do |child|
        self.class.new(child.to_path)
      end
    end

    def ancestors
      ancestors = []
      pathname.ascend do |path|
        next if path == pathname
        ancestors << self.class.new(path.to_path)
      end
      ancestors
    end

    def to_object
      { object_key => object_value }
    end

    private

    def object_key
      if directory?
        if @scan_children
          pathname.to_s + '/'
        else
          pathname.to_s + '/**/*'
        end
      else
        pathname.to_s
      end
    end

    def object_value
      @description
    end
  end
end
