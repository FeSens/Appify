import { Controller } from "stimulus"

import AutomationBlocksController from "./automation_blocks_controller"
export default class extends AutomationBlocksController {
  static targets = ["cardInputs", "templateNameLable"]
  static values = {
    template: String,
    templateName: String,
  }

  initialize() {
    this.urlValue = this.templateValue || "bem vindo";
    this.render_inputs()
  }

  templateValueChanged() {
    this.templateNameLableTarget.innerHTML = this.templateNameValue;
    this.render_inputs()
  }

  render_inputs() {
    this.cardInputsTarget.innerHTML = `
      <input type="hidden" name="template" class="hidden-input" value="${this.templateValue}">
    `
  }

  render_properties() {
    var template = this.properties_template.content.cloneNode(true)
    return template 
  }

}