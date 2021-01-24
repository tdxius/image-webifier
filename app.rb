require 'rmagick'
require 'fileutils'

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
  out_file = file.gsub('/input/', '/output/')

  width = original_image.columns
  height = original_image.rows
  if width > 1000 || height > 0
    transformed_image = original_image.resize_to_fit!(1000, 1000)
  else
    transformed_image = original_image
  end

  FileUtils.mkdir_p(out_file.split('/')[0..-2].join('/'))
  transformed_image.write(out_file) do
    self.quality = 80
  end
  pp [
         out_file,
         transformed_image.columns,
         transformed_image.rows,
         file_size(file),
         file_size(out_file)
     ]
rescue
  puts "#{file} is not an image."
end

puts "Input size: #{directory_size('storage/input')} Mb"
puts "Output size: #{directory_size('storage/output')} Mb"