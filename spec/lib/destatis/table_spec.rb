# frozen_string_literal: true

require "rails_helper"

RSpec.describe(Destatis::Table) do
  let(:time) { Time.zone.local(2024, 9, 3) }
  subject { described_class.new(startyear: "2023", endyear: "2024", time:) }

  before do
    travel_to time
    stub_request(:get, "https://www-genesis.destatis.de/genesisWS/rest/2020/data/table")
      .with(query: {
        startyear: "2023",
        endyear: "2024",
        stand: "03.09.24 00:09",
        language: "en",
        name: "61111-0002",
        username: "u",
        password: "p",
      })
      .to_return(status: status, body: body.to_json, headers: {})
  end

  after do
    travel_back
  end

  shared_examples "request parse and request log" do |array_size|
    it do
      expect do
        expect(subject.parsed_content.length).to(eql(array_size))
      end.to(change(RequestLog, :count).by(1))
      request_log = RequestLog.last
      expect(request_log.status_code).to(eql(status))
      expect(request_log.body).not_to(be_empty)
      expect(request_log.data).not_to(be_empty)
      expect(request_log.class_name).to(eql(described_class.to_s))
    end
  end

  describe ".parsed_content" do
    context "200 with content" do
      let(:status) { 200 }
      let(:body) do
        {
          "Object" => {
            "Content" =>
            "GENESIS-Tabelle: 61111-0002\n" \
              "Consumer price index: Germany, months;;;;\n" \
              "Consumer price index for Germany;;;;\n" \
              "Germany;;;;\n" \
              ";;Consumer price index;Change on previous year's month;Change on previous month\n" \
              ";;2020=100;in (%);in (%)\n" \
              "2023;January;114.3;+8.7;+1.0\n" \
              "2023;February;115.2;+8.7;+0.8\n" \
              "2023;March;116.1;+7.4;+0.8\n" \
              "2023;April;116.6;+7.2;+0.4\n" \
              "2023;May;116.5;+6.1;-0.1\n" \
              "2023;June;116.8;+6.4;+0.3\n" \
              "2023;July;117.1;+6.2;+0.3\n" \
              "2023;August;117.5;+6.1;+0.3\n" \
              "2023;September;117.8;+4.5;+0.3\n" \
              "2023;October;117.8;+3.8;-\n" \
              "2023;November;117.3;+3.2;-0.4\n" \
              "2023;December;117.4;+3.7;+0.1\n" \
              "2024;January;117.6;+2.9;+0.2\n" \
              "2024;February;118.1;+2.5;+0.4\n" \
              "2024;March;118.6;+2.2;+0.4\n" \
              "2024;April;119.2;+2.2;+0.5\n" \
              "2024;May;119.3;+2.4;+0.1\n" \
              "2024;June;119.4;+2.2;+0.1\n" \
              "2024;July;119.8;+2.3;+0.3\n" \
              "2024;August;...;...;...\n" \
              "2024;September;...;...;...\n" \
              "2024;October;...;...;...\n" \
              "2024;November;...;...;...\n" \
              "2024;December;...;...;...\n" \
              "__________\n" \
              "Â© Federal Statistical Office, Wiesbaden 2024\n" \
              "created: 2024-09-03 / 09:25:17\n",
          },
        }
      end
      it_should_behave_like "request parse and request log", 33
    end

    context "200 without content" do
      let(:status) { 200 }
      let(:body) { {} }
      it_should_behave_like "request parse and request log", 0
    end

    context "404 without content" do
      let(:status) { 404 }
      let(:body) do
        { "Code" => 2, "Content" => "An error has occured. (Your username or password is wrong.)", "Type" => "ERROR" }
      end
      it_should_behave_like "request parse and request log", 0
    end
  end
end
