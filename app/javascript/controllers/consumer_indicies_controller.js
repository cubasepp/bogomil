import { Controller } from "@hotwired/stimulus"
export default class extends Controller {

  static targets = [
    "calculatorOldIndex",
    "calculatorNewIndex",
    "calculatorForm",
    "snapContainer",
    "indexFrame",
    "btn"
  ]

  initialize() {
    this.path = "/consumer_indicies/"
    this.indexData = {
      oldIndex: {
        year: null,
        month: null
      },
      newIndex: {
        year: null,
        month: null
      }
    }
  }

  connect() {
    this.element.addEventListener('turbo:frame-render', this.onTurboRender.bind(this))
  }

  disconnect() {
    this.element.removeEventListener('turbo:frame-render', this.onTurboRender)
  }

  onTurboRender(event) {
    const newTarget = this.calculatorNewIndexTarget;
    const oldTarget = this.calculatorOldIndexTarget;
    if (!!newTarget.value && !!oldTarget.value) {
      this.calculatorFormTarget.requestSubmit();
    }
  }

  selectBadge(event) {
    const currentTarget = event.currentTarget;
    const frameId = currentTarget.dataset.frameId;
    const type = currentTarget.dataset.type;
    const data = this.indexData[frameId]

    if (currentTarget.value) {
      data[type] = currentTarget.value
    }

    if (data.year && data.month) {
      this.btnTargets.forEach((btn) => {
        if (btn.dataset.frameId === frameId && btn.disabled) {
          btn.disabled = !btn.disabled
        }
      });
      this.#fetchIndex(frameId, data)
    }
  }

  toggleSnap(event) {
    const direction = event.currentTarget.dataset.frameId;
    const snapContainer = this.snapContainerTarget;
    let left = null;

    if(direction === "newIndex") {
      left = snapContainer.scrollLeft - snapContainer.offsetWidth
    } else {
      left = snapContainer.scrollLeft + snapContainer.offsetWidth;
    }
    snapContainer.scrollTo({ left: left, behavior: "smooth" });
    this.#toggleBtns();
  }

  #toggleBtns() {
    this.btnTargets.forEach((btn) => {
      btn.disabled = !btn.disabled
    });
  }

  #fetchIndex(frameId, data) {
    this.indexFrameTargets.forEach((indexFrame) => {
      if (indexFrame.dataset.frameId === frameId) {
        indexFrame.src = this.path + this.#indexId(data) + "?frame_id=" + frameId;
      }
    });
  }

  #indexId(data) {
    return data.year + "-" + data.month;
  }
}
