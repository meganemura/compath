module Compath
  class CLI
    def self.run
      finder = Compath::Finder.new
      paths = Compath::PathSorter.sort(finder.paths.keys)

      guides = paths.map {|path| Compath::Guide.new(path) }
      guides.select!(&:directory?)
      guide_book = Compath::GuideBook.new(guides)

      if FileTest.exist?('.compath.yml')
        config = Compath::ConfigLoader.load(File.read('.compath.yml'))
        guide_book.merge(config)
      else
        initial_config_guides = paths.map {|path| Compath::Guide.new(path, scan: false) }
        initial_config_guides.select!(&:directory?)
        initial_config = Compath::GuideBook.new(initial_config_guides)
        guide_book.merge(initial_config.guides)
      end

      yaml = guide_book.publish_yaml

      File.write('.compath.yml', yaml)
      puts 'Write .compath.yml'
    end
  end
end
