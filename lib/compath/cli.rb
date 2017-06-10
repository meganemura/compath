module Compath
  class CLI
    def self.run
      finder = Compath::Finder.new
      paths = Compath::PathSorter.sort(finder.paths.keys)

      guides = paths.map {|path| Compath::Guide.new(path) }
      guide_book = Compath::GuideBook.new(guides)
      if FileTest.exist?('.compath.yml')
        config = Compath::ConfigLoader.load(File.read('.compath.yml'))
        guide_book.merge(config)
      end

      yaml = guide_book.publish_yaml

      puts yaml
    end
  end
end
