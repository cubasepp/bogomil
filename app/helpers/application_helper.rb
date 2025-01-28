# frozen_string_literal: true

module ApplicationHelper
  def main_turbo_frame_tag(tag_id = nil, &block)
    turbo_frame_tag(:main_content) do
      turbo_frame_tag(tag_id) do
        yield if block_given?
      end
    end
  end

  def tab_link(label, url: root_path, disabled: false, active: false, turbo_frame: "main_content")
    link_to(
      label,
      url,
      class:
      class_names(
        "tab",
        "[--tab-bg:var(--fallback-b2,oklch(var(--b2)))]",
        { "tab-active": active },
      ),
      role: "tab",
      disabled:,
      data: {
        turbo_frame:,
      },
    )
  end
end
