# frozen_string_literal: true

module ApplicationHelper
  def main_turbo_frame_tag(tag_id = nil, &block)
    turbo_frame_tag(:main_content) do
      turbo_frame_tag(tag_id) do
        safe_join([
          render("shared/flash_message"),
          capture(&block),
        ])
      end
    end
  end

  def render_turbo_stream_flash_messages
    turbo_stream.replace(:flash_messages, partial: "shared/flash_message")
  end

  def tab_link(label, url: root_path, disabled: false, active: false, turbo_frame: "_top")
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
