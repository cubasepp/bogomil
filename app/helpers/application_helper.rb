# frozen_string_literal: true

module ApplicationHelper
  def link_to_active(name = nil, options = nil, html_options = nil, &block)
    html_options ||= {}
    html_options[:class] = class_names(html_options&.dig(:class), { active: current_page?(options) })

    link_to(name, options, html_options, &block)
  end
end
