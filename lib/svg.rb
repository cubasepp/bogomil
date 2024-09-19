# frozen_string_literal: true

class Svg
  class << self
    def document(options = {})
      svg(options) do
        "M19.5 14.25v-2.625a3.375 3.375 0 0 0-3.375-3.375h-1.5A1.125 1.125 \
        0 0 1 13.5 7.125v-1.5a3.375 3.375 0 0 0-3.375-3.375H8.25m2.25 0H5.625c-.621 \
        0-1.125.504-1.125 1.125v17.25c0 .621.504 1.125 1.125 1.125h12.75c.621 0 \
        1.125-.504 1.125-1.125V11.25a9 9 0 0 0-9-9Z"
      end
    end

    def bars_3(options = {})
      svg(options) do
        "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
      end
    end

    def arrow_tranding_down(options = {})
      svg(options) do
        "M2.25 6 9 12.75l4.286-4.286a11.948 11.948 0 0 1 4.306 \
        6.43l.776 2.898m0 0 3.182-5.511m-3.182 5.51-5.511-3.181"
      end
    end

    def arrow_tranding_up(options = {})
      svg(options) do
        "M2.25 18 9 11.25l4.306 4.306a11.95 11.95 0 0 \
        1 5.814-5.518l2.74-1.22m0 0-5.94-2.281m5.94 2.28-2.28 5.941"
      end
    end

    def moon(options = {})
      svg(options) do
        "M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 \
        0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 \
        12.75 21a9.753 9.753 0 0 0 9.002-5.998Z"
      end
    end

    private

    def svg(options = {}, &block)
      "<svg xmlns=\"http://www.w3.org/2000/svg\"
      fill=\"none\"
      viewBox=\"0 0 24 24\"
      stroke-width=\"1.5\"
      stroke=\"currentColor\"
      class=\"#{options.fetch(:css, "")}\">
      <path stroke-linecap=\"round\" stroke-linejoin=\"round\" d=\"#{(yield block).squish}\" />
      </svg>"
    end
  end
end
