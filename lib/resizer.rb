require 'rmagick'

class Resizer
  class << self
    MAX_WIDTH = 1000.freeze
    MAX_HEIGHT = 1000.freeze

    def resize(image)
      return image unless needs_resize?(image)

      image.resize_to_fit!(MAX_WIDTH, MAX_HEIGHT)
    end

    private

    def needs_resize?(image)
      width = image.columns
      height = image.rows

      width > MAX_WIDTH || height > MAX_HEIGHT
    end
  end
end