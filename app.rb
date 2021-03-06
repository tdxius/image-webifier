require 'rmagick'
require 'fileutils'
require_relative 'lib/resizer'
require_relative 'lib/directory'

Dir.glob("storage/input/**/*").each do |file|
  next if File.directory?(file)

  original_image = Magick::Image.read(file).first
  transformed_image = Resizer.resize(original_image)
  out_file = file.gsub('/input/', '/output/')

  Directory.create_for_file(out_file)
  transformed_image.write(out_file) do
    self.quality = 80
  end

  puts out_file
rescue
  puts "An error occurred with file #{file}"
end

puts "Input size: #{Directory.size('storage/input')} Mb"
puts "Output size: #{Directory.size('storage/output')} Mb"