import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["root", "navigation", "content"];

  initialize() {}

  toggleDarkMode(event) {
    const currentTarget = event.currentTarget;
    this.rootTarget.classList.toggle("dark");
    [...currentTarget.children].forEach((element) =>
      element.classList.toggle("hidden"),
    );
  }
  expandNavigation(event) {
    this.navigationTarget.classList.toggle("-translate-x-full");
  }
}
