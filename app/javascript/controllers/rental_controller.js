import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["tenants"]

  addTenant() {
    const target = this.tenantsTargets

    alert("Hello");
  }
}
