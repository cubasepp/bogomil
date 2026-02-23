# frozen_string_literal: true

class ChartsController < ApplicationController
  def consumer_indicies
    data = ConsumerIndex.where(year: Date.current.year)
    @turbo_frame_tag_id = :consumer_index_chart

    @chart_data = {
      labels: data.map { |entry| entry.date.strftime("%Y-%m") },
      datasets: [{
        label: I18n.t("consumer_index.chart.dataset"),
        backgroundColor: "transparent",
        data: data.pluck(:index),
      }],
    }
    @chart_options = {
      plugins: {
        title: {
          display: true,
          text: I18n.t("consumer_index.chart.title"),
        },
      },
      scales: {
        x: {
          title: {
            display: true,
            text: I18n.t("consumer_index.chart.xtitle"),
          },
        },
        y: {
          title: {
            display: true,
            text: I18n.t("consumer_index.chart.ytitle"),
          },
        },
      },
    }
    render(:show)
  end
end
