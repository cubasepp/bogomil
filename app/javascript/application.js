import "@hotwired/turbo-rails";
import "./controllers";
import "@hotwired/turbo-rails";
import "chartkick/chart.js";

import { Turbo } from "@hotwired/turbo-rails"

Turbo.StreamActions.redirect = function () {
  Turbo.visit(this.target);
};
