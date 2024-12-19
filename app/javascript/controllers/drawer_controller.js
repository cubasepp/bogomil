import { Controller } from "@hotwired/stimulus";
import { patch } from "@rails/request.js";

export default class extends Controller {
  static targets = ["root", "toggle", "link"];
  static values = {
    activeClass: { type: String, default: "active" },
    collectionPath: { type: String, default: "/collections/" },
  };

  connect() {
    this.element.addEventListener(
      "turbo:frame-render",
      this.onTurboRender.bind(this),
    );
  }

  disconnect() {
    this.element.removeEventListener("turbo:frame-render", this.onTurboRender);
  }

  onTurboRender(event) {
    this.clearActiveClass();
    this.addActiveClass();
    this.hideToggleDrawer();
  }

  collapseToggle(event) {
    patch(`${this.collectionPathValue}${event.params.id}`, {
      responseKind: "turbo-stream",
    });
  }

  hideToggleDrawer() {
    if (this.toggleTarget.checked) {
      this.toggleTarget.checked = false;
    }
  }

  addActiveClass() {
    const currentLink = this.linkTargets.find(
      (link) => link.href === window.location.href,
    );

    if (currentLink) {
      currentLink.classList.add(this.activeClassValue);
    } else {
      this.rootTarget.classList.add(this.activeClassValue);
    }
  }

  clearActiveClass() {
    this.linkTargets.forEach((link) =>
      link.classList.remove(this.activeClassValue),
    );
  }
}
