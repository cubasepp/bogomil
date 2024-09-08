import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [
    "root",
    "moon"
  ]

  initialize() {}

  toggle() {
    this.rootTarget.classList.toggle("dark");
  }
}
