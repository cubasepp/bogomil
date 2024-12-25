import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["field"];

  toggleEnableDisable(event) {
    this.fieldTargets.forEach((element) => {
      element.disabled = !event.target.checked;
    });
  }
}
