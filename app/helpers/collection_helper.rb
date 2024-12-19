# frozen_string_literal: true

module CollectionHelper
  def collapsed?(collection)
    if collection.collapsed_for?
      "open"
    end
  end
end
