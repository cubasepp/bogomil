import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["tenantList", "tenants"];

  addTenant() {
    const lastTenant = this.tenantsTargets[this.tenantsTargets.length - 1];
    const newTenant = lastTenant.cloneNode(true);

    newTenant
      .querySelectorAll(".text-error")
      .forEach((error) => error.remove());
    newTenant.querySelectorAll("input, select, textarea").forEach((input) => {
      input.value = "";
      input.classList.remove("input-erro");
    });

    this.tenantListTarget.appendChild(newTenant);
    this.reindexToggleBtnTenants();
  }

  removeTenant(event) {
    const target = event.currentTarget;
    const tenantId = target.dataset.tenantId;

    if (this.tenantsTargets[tenantId]) {
      this.tenantsTargets[tenantId].remove();
      this.reindexToggleBtnTenants();
    }
  }

  reindexToggleBtnTenants() {
    this.reindexTenants();
    this.toggleRemoveButtons();
  }

  reindexTenants() {
    this.tenantsTargets.forEach((tenant, index) => {
      this.updateElementIndices(tenant, index);
    });
  }

  updateElementIndices(tenant, index) {
    // Update tenant container
    tenant.id = tenant.id.replace(/\d+/, index);

    // Update form elements
    tenant.querySelectorAll("input, select").forEach((element) => {
      element.id = element.id.replace(/\d+/, index);
      element.name = element.name.replace(/\d+/, index);
    });

    // Update labels
    tenant.querySelectorAll("label").forEach((label) => {
      if (label.htmlFor) {
        label.htmlFor = label.htmlFor.replace(/\d+/, index);
      }
    });

    // Update data attributes
    tenant.querySelectorAll("[data-tenant-id]").forEach((element) => {
      element.dataset.tenantId = index;
    });
  }

  toggleRemoveButtons() {
    const isDisabled = this.tenantsTargets.length === 1;

    this.element
      .querySelectorAll('[data-action="rental#removeTenant"]')
      .forEach((button) => {
        button.disabled = isDisabled;
      });
  }
}
