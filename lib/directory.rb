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

    def create_for_file(file_path)
      out_directory = file_path.split('/')[0..-2].join('/')
      FileUtils.mkdir_p(out_directory)
    end

    private

    def file_size(file)
      (File.size(file).to_f / 2 ** 20).round(2)
    end
  end
end