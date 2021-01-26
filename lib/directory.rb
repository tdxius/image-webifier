class Directory
  class << self
    def size(path)
      files = Dir.glob("#{path}/**/*")
      files.sum do |file|
        if File.directory?(file)
          0
        else
          file_size(file).to_f
        end
      end
    end

    private

    def file_size(file)
      (File.size(file).to_f / 2 ** 20).round(2)
    end
  end
end