# frozen_string_literal: true

module ConfigBuilder
  MissingConfig = Class.new(StandardError)

  def setting(key, **opts)
    define_singleton_method(key) do
      val = ENV[key.to_s.upcase].presence || opts[:default]
      ConfigBuilder.cast(val, opts[:type])
    end
    return unless opts[:alias]

    define_singleton_method(opts[:alias]) do
      send(key)
    end
  end

  class << self
    def cast(val, type)
      return unless val

      case type
      when :integer then Integer(val)
      when :float then Float(val)
      when :symbol then val.to_sym
      when :boolean then ["1", "true", "True", "TRUE", true].include?(val)
      when :array, :hash then JSON.parse(val)
      else val
      end
    end
  end
end
