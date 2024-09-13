import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "root"
  ]

  initialize() {}

  toggle() {
    this.rootTarget.classList.toggle("dark");
  }
}
