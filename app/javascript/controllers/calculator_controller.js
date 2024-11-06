import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["oldIndex", "newIndex", "frame", "calculate"];

  initialize() {
    this.path = "/consumer_indicies/";
  }

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
    const target = event.target;
    const value = target.innerHTML.trim();
    const targetId = target.dataset.target;
    const inputTargets = this.targets
      .findAll("oldIndex", "newIndex")
      .filter((el) => el instanceof HTMLInputElement);

    const inputTarget = inputTargets.find(
      (el) => el.dataset.calculatorTarget === targetId,
    );

    if (inputTarget !== undefined) {
      inputTarget.value = value;
    }
    const selectedValues = inputTargets
      .filter((el) => el.value)
      .map((el) => el.value);
    if (selectedValues.length == 2) {
      this.calculateTarget.requestSubmit();
    }
  }

  select(event) {
    const target = event.currentTarget;
    const frameId = target.dataset.calculatorTarget;
    const targets = this.targets
      .findAll(frameId)
      .filter((el) => el instanceof HTMLSelectElement);
    const targetFrame = this.frameTargets.find(
      (el) => el.dataset.target === frameId,
    );

    const selectedValues = targets
      .filter((el) => el.value)
      .map((el) => el.value);

    if (target.dataset.next !== undefined) {
      const targetValue = target.value;
      const nextTarget = targets.find((el) => el !== target);
      if (!!!targetValue) {
        nextTarget.value = "";
      }
      nextTarget.disabled = !!!targetValue;
    }

    if (selectedValues.length == 2) {
      targetFrame.src = "/consumer_indicies/" + selectedValues.join("-");
    } else {
      targetFrame.src = "";
    }
  }
}
