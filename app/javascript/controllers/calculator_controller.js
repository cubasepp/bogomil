import { Controller } from "@hotwired/stimulus";
import { post } from "@rails/request.js";

export default class extends Controller {
  static targets = ["oldIndex", "oldIndexValue", "newIndex", "newIndexValue"];
  static values = {
    consumerIndiciesPath: { type: String, default: "/consumer_indicies/" },
    calculateUrl: { type: String, default: "/calculator" },
    oldIndex: String,
    newIndex: String,
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
    const target = event.target;
    const dataSetTarget = target.dataset.calculatorTarget;
    this[`${dataSetTarget}Value`] =
      this[`${dataSetTarget}ValueTarget`].innerHTML.trim();

    if (this.hasValidIndices) {
      this.calculate();
    }
  }

  onSelection({ detail }) {
    const { frameId, id } = detail;
    this[`${frameId}Target`].src = `${this.consumerIndiciesPathValue}${id}`;
  }

  calculate() {
    post(this.calculateUrlValue, {
      body: {
        calculator: {
          old_index: this.oldIndexValue,
          new_index: this.newIndexValue,
        },
      },
      responseKind: "turbo-stream",
    });
  }

  get hasValidIndices() {
    return Boolean(this.oldIndexValue) && Boolean(this.newIndexValue);
  }
}
