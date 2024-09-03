# frozen_string_literal: true

class ConsumerIndexJob < ApplicationJob
  self.queue_adapter = :solid_queue
  queue_as :default

  def perform(time: Time.zone.now)
    @time = time

    ConsumerIndex.create(consumer_index_data)
  end

  def consumer_index_data
    parsed_content.filter_map do |line|
      next if line.compact.size != 5
      next if line[2..4].all? { _1 == "..." }

      {
        year: line[0],
        month: Date::MONTHNAMES.index(line[1]),
        index: line[2],
        previous_year: line[3],
        previous_month: line[4],
      }
    end
  end

  private

  def parsed_content
    @parsed_content = destatis_table.parsed_content
  end

  def destatis_table
    @destatis_table ||= Destatis::Table.new(
      startyear: @time.prev_year.year,
      endyear: @time.year,
      time: @time,
    )
  end
end
