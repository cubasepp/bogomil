import Chartjs from "@stimulus-components/chartjs";

export default class extends Chartjs {
  connect() {
    super.connect();

    const primaryColor = getComputedStyle(document.documentElement)
      .getPropertyValue("--color-primary")
      .trim();

    this.chart.data.datasets.forEach((dataset) => {
      dataset.borderColor = primaryColor;
    });
    this.chart.update();
  }
}
