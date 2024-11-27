import { Controller } from "@hotwired/stimulus";
export default class extends Controller {
  static targets = ["month", "year"];
  static values = {
    frameId: String,
    setting: Array,
  };

  initialize() {}

  selectYear(event) {
    const target = event.currentTarget;
    const monthTarget = this.monthTarget;
    const maxMonthFor = this.maxMonthFor(target.value);

    monthTarget.disabled = !target.value;
    if (monthTarget.disabled) {
      monthTarget.value = "";
    } else {
      Array.from(monthTarget.options).forEach((option) => {
        option.disabled = parseInt(maxMonthFor) < parseInt(option.value);
      });
    }
    this.emitEvent();
  }

  selectMonth(event) {
    this.emitEvent();
  }

  emitEvent() {
    const month = this.monthTarget.value;
    const year = this.yearTarget.value;

    if (Boolean(month) && Boolean(year)) {
      this.element.dispatchEvent(
        new CustomEvent("calculator:selection", {
          detail: { frameId: this.frameIdValue, id: `${year}-${month}` },
          bubbles: true,
        }),
      );
    }
  }

  maxMonthFor(year) {
    return this.settingValue.find((setting) => setting.year == year)?.month;
  }
}
