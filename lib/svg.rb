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

    def sun(options = {})
      svg(options) do
        "M12 3v2.25m6.364.386-1.591 1.591M21 12h-2.25m-.386 6.364-1.591-1.591M12
        18.75V21m-4.773-4.227-1.591 1.591M5.25 12H3m4.227-4.773L5.636 5.636M15.75 \
        12a3.75 3.75 0 1 1-7.5 0 3.75 3.75 0 0 1 7.5 0Z"
      end
    end

    def bars_3(options = {})
      svg(options) do
        "M3.75 6.75h16.5M3.75 12h16.5m-16.5 5.25h16.5"
      end
    end

    def arrow_tranding_down(options = {})
      svg(options) do
        "M2.25 18 9 11.25l4.306 4.306a11.95 11.95 0 0 1 \
        5.814-5.518l2.74-1.22m0 0-5.94-2.281m5.94 2.28-2.28 5.941"
      end
    end

    def arrow_tranding_up(options = {})
      svg(options) do
        "M2.25 6 9 12.75l4.286-4.286a11.948 11.948 0 0 \
        1 4.306 6.43l.776 2.898m0 0 3.182-5.511m-3.182 5.51-5.511-3.181"
      end
    end

    def moon(options = {})
      svg(options) do
        "M21.752 15.002A9.72 9.72 0 0 1 18 15.75c-5.385 0-9.75-4.365-9.75-9.75 \
        0-1.33.266-2.597.748-3.752A9.753 9.753 0 0 0 3 11.25C3 16.635 7.365 21 \
        12.75 21a9.753 9.753 0 0 0 9.002-5.998Z"
      end
    end

    def x_circle(options = {})
      svg(options) do
        "M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z"
      end
    end

    def check_circle(options = {})
      svg(options) do
        "M9 12.75 11.25 15 15 9.75M21 12a9 9 0 1 1-18 0 9 9 0 0 1 18 0Z"
      end
    end

    def percent_badge(options = {})
      svg(options) do
        "m8.99 14.993 6-6m6 3.001c0 1.268-.63 2.39-1.593 3.069a3.746 3.746 0 0 1-1.043 3.296 \
        3.745 3.745 0 0 1-3.296 1.043 3.745 3.745 0 0 1-3.068 1.593c-1.268 0-2.39-.63-3.068-1.593a3.745 \
        3.745 0 0 1-3.296-1.043 3.746 3.746 0 0 1-1.043-3.297 3.746 3.746 0 0 1-1.593-3.068c0-1.268.63-2.39 \
        1.593-3.068a3.746 3.746 0 0 1 1.043-3.297 3.745 3.745 0 0 1 3.296-1.042 3.745 3.745 0 0 1 3.068-1.594c1.268 \
        0 2.39.63 3.068 1.593a3.745 3.745 0 0 1 3.296 1.043 3.746 3.746 0 0 1 1.043 3.297 3.746 3.746 0 0 1 1.593  \
        3.068ZM9.74 9.743h.008v.007H9.74v-.007Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm4.125 \
        4.5h.008v.008h-.008v-.008Zm.375 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Z"
      end
    end

    def hashtag(options = {})
      svg(options) do
        "M5.25 8.25h15m-16.5 7.5h15m-1.8-13.5-3.9 19.5m-2.1-19.5-3.9 19.5"
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
