module Compath
  class CLI
    def self.run
      finder = Compath::Finder.new
      paths = Compath::PathSorter.sort(finder.paths.keys)

      config = Compath::ConfigLoader.load(File.read('.compath.yml'))

      guides = paths.map {|path| Compath::Guide.new(path) }
      guide_book = Compath::GuideBook.new(guides)
      guide_book.merge(config)

      yaml = guide_book.publish_yaml

      puts yaml
    end
  end
end
