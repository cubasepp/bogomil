# frozen_string_literal: true

# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/stimulus", to: "@hotwired--stimulus.js" # @3.2.2
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"
pin "@hotwired/turbo-rails", to: "turbo.min.js"

pin_all_from "app/javascript/controllers", under: "controllers"

pin "@stimulus-components/chartjs", to: "@stimulus-components--chartjs.js" # @6.0.1
pin "@kurkle/color", to: "@kurkle--color.js" # @0.3.4
pin "chart.js", to: "https://ga.jspm.io/npm:chart.js@4.5.1/dist/chart.js" # to: "chart.js" # @4.5.1
pin "@rails/request.js", to: "@rails--request.js.js" # @0.0.13
