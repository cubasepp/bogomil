# frozen_string_literal: true

module CollectionHelper
  def collapsed?(collection, user_id:)
    if collection.collapsed_for?(user_id:)
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
