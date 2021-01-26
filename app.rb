require 'rmagick'
require 'fileutils'
require_relative 'lib/resizer'

def file_size(file)
  (File.size(file).to_f / 2 ** 20).round(2)
end

def directory_size(directory_path)
  Dir.glob("#{directory_path}/**/*").sum do |file|
    if File.directory?(file)
      0
    else
      file_size(file).to_f
    end
  end
end

Dir.glob("storage/input/**/*").each do |file|
  next if File.directory?(file)

  original_image = Magick::Image.read(file).first
  transformed_image = Resizer.resize(original_image)

  out_file = file.gsub('/input/', '/output/')
  out_directory = out_file.split('/')[0..-2].join('/')
  FileUtils.mkdir_p(out_directory)

  transformed_image.write(out_file) do
    self.quality = 80
  end
  puts out_file
rescue
  puts "An error occurred with file #{file}"
end

puts "Input size: #{directory_size('storage/input')} Mb"
puts "Output size: #{directory_size('storage/output')} Mb"