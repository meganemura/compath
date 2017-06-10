module Compath
  class Finder
    def files
      @files ||= begin
                   files = `git ls-files -z`.split("\x0")
                   files.map {|file| Pathname.new(file) }
                 end
    end

    def paths
      files.each_with_object({}) do |file, hash|
        file.descend do |pathname|
          hash[pathname.to_path] = true
        end
      end
    end
  end
end
