module Compath
  # TODO: Remove Pathname
  # Sorted files and directories are ordered as below
  #   1. directory
  #   2. file
  module PathSorter
    module_function

    def sort(paths)
      sorted_pathnames.map(&:to_path) & paths
    end

    def sorted_pathnames(path = '.')
      collected = []
      current = Pathname.new(path)
      if current.directory?
        collected << current
        collected += current.children.flat_map { |child| sorted_pathnames(child) }
      else
        collected << current
      end

      collected
    end
  end
end
