# frozen_string_literal: true

module CollectionHelper
  def collapsed?(collection)
    if collection.collapsed_for?
      "open"
    end
  end

  def drawer_link(url, &block)
    link_to(
      url,
      css: "group",
      data: {
        turbo_action: "advance",
        turbo_frame: "main_content",
        drawer_target: "link",
      },
    ) do
      yield block
    end
  end
end
