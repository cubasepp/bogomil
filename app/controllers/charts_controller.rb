# frozen_string_literal: true

class ChartsController < ApplicationController
  def consumer_indicies
    @data = ConsumerIndex.where(year: Date.current.year).map do |entry|
      [entry.date.strftime("%Y-%m"), entry.index]
    end
    @setting = {
      turbo_frame_tag_id: :consumer_index_chart,
      min: 100,
      title: I18n.t("consumer_index.chart.title"),
      xtitle: I18n.t("consumer_index.chart.xtitle"),
      ytitle: I18n.t("consumer_index.chart.ytitle"),
    }
    render(:show)
  end
end
