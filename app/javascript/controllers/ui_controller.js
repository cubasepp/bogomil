import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["root"];

  initialize() {}

  toggleDarkMode(event) {
    const currentTarget = event.currentTarget;
    this.rootTarget.dataset.theme = currentTarget.checked ? "coffee" : "retro";
  }
}
