# frozen_string_literal: true

module ApplicationHelper
  def main_turbo_frame_tag(tag_id = nil, &block)
    turbo_frame_tag :main_content do
      turbo_frame_tag tag_id do
        yield if block_given?
      end
    end
  end
end
