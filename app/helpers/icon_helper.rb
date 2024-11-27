# frozen_string_literal: true

module IconHelper
  def icon(name, *options)
    raw(Svg.send(name, *options)) # rubocop:disable Rails/OutputSafety
  end
end
