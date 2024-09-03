# frozen_string_literal: true

require "rails_helper"

RSpec.describe(ConsumerIndexJob, type: :job) do
  subject { described_class }
  let(:time) { Time.zone.local(2024, 9, 3) }

  before do
    travel_to time
  end

  after do
    travel_back
  end

  describe do
    it "has a enqueued job" do
      expect do
        subject.perform_later
      end.to(have_enqueued_job)
    end
  end

  describe "defaut args" do
    let(:destatis_table) { instance_double(Destatis::Table, parsed_content: content) }

    before do
      allow(Destatis::Table).to(receive(:new).with(
        startyear: 2023,
        endyear: 2024,
        time: time,
      )).and_return(destatis_table)
    end

    context do
      let(:content) { [["2024", "January", "100.5", "+2.3", "-0.2"], ["2024", "Feburary", "---", "---", "---"]] }
      it "contains csv data" do
        expect do
          subject.perform_now
        end.to(change(ConsumerIndex, :count).by(2))
      end
    end

    context do
      let(:content) { [] }
      it "contains no csv data" do
        expect do
          subject.perform_now
        end.not_to(change(ConsumerIndex, :count))
      end
    end

    context do
      let(:content) { [["2024", "January", "100.5", "+2.3", "-0.2"], ["2024", "January", "100.5", "+2.3", "-0.2"]] }
      it "contains duplicates values" do
        expect do
          subject.perform_now
        end.to(change(ConsumerIndex, :count).by(1))
      end
    end
  end
end
