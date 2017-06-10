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
      scan_or_not = if !directory? || @scan_children
                      {}
                    else
                      {
                        'scan' => false
                      }
                    end

      object = {
                 object_key => {
                   'desc' => @description
                 }.merge(scan_or_not)
               }

      object
    end

    def object_key
      if directory?
        pathname.to_s + '/'
      else
        pathname.to_s
      end
    end
  end
end
